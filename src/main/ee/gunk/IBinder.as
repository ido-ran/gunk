package ee.gunk
{
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.binder.IAnnotatedBindingBuilder;
	import ee.gunk.binder.ILinkedBindingBuilder;

	/**
	 * Documentation below is copied from Guice's Binder interface and modified to 
	 * reflect the way Gunk works.
	 * 
	 * Collects configuration information (primarily <i>bindings</i>) which will be
	 * used to create an IInjector. Gunk provides this object to your
	 * application's IModule implementors so they may each contribute
	 * their own bindings and other registrations.
	 *
	 * <h3>The Gunk Binding EDSL</h3>
	 *
	 * Gunk uses an <i>embedded domain-specific language</i>, or EDSL, to help you
	 * create bindings simply and readably.  This approach is great for overall
	 * usability, but it does come with a small cost: <b>it is difficult to
	 * learn how to use the Binding EDSL by reading
	 * method-level asdocs</b>.  Instead, you should consult the series of
	 * examples below.  To save space, these examples omit the opening
	 * <code>binder</code>, just as you will if your module extends
	 * AbstractModule.
	 *
	 * <listing>
	 *     bind(ServiceImpl);
	 * </listing>
	 *
	 * This statement does essentially nothing; it "binds the <code>ServiceImpl</code>
	 * class to itself" and does not change Gunk's default behavior.  You may still
	 * want to use this if you prefer your IModule class to serve as an
	 * explicit <i>manifest</i> for the services it provides.  Also, in rare cases,
	 * Gunk may be unable to validate a binding at injector creation time unless it
	 * is given explicitly.
	 *
	 * <listing>
	 *     bind(Service).to(ServiceImpl);
	 * </listing>
	 *
	 * Specifies that a request for a <code>Service</code> instance with no binding
	 * annotations should be treated as if it were a request for a
	 * <code>ServiceImpl</code> instance. This <i>overrides</i> the function of any
	 * [ImplementedBy] or [ProvidedBy]
	 * annotations found on <code>Service</code>, since Gunk will have already
	 * "moved on" to <code>ServiceImpl</code> before it reaches the point when it starts
	 * looking for these annotations.
	 *
	 * <listing>
	 *     bind(Service).toProvider(ServiceProvider);
	 * </listing>
	 *
	 * In this example, <code>ServiceProvider</code> must extend or implement
	 * <code>IProvider</code>. This binding specifies that Gunk should resolve
	 * an unannotated injection request for <code>Service</code> by first resolving an
	 * instance of <code>ServiceProvider</code> in the regular way, then calling
	 * <code>get()</code> on the resulting Provider instance to obtain the
	 * <code>Service</code> instance.
	 *
	 * <p>The IProvider you use here does not have to be a "factory"; that
	 * is, a provider which always <i>creates</i> each instance it provides.
	 * However, this is generally a good practice to follow.  You can then use
	 * Gunk's concept of scopes to guide when creation should happen
	 * -- "letting Gunk work for you".
	 *
	 * <listing>
	 *     bind(Service).annotatedWith(Red).to(ServiceImpl);
	 * </listing>
	 *
	 * Like the previous example, but only applies to injection requests that use
	 * the binding annotation <code>[Red]</code>.  If your module also includes bindings
	 * for particular <i>values</i> of the <code>[Red]</code> annotation (see below),
	 * then this binding will serve as a "catch-all" for any values of <code>[Red]</code>
	 * that have no exact match in the bindings.
	 * 
	 * <listing>
	 *     bind(ServiceImpl).inScope(Scopes.SINGLETON);
	 *     // or, alternatively
	 *     bind(ServiceImpl).asSingleton();
	 * </listing>
	 *
	 * Either of these statements places the <code>ServiceImpl</code> class into
	 * singleton scope.  Gunk will create only one instance of <code>ServiceImpl</code>
	 * and will reuse it for all injection requests of this type.  Note that it is
	 * still possible to bind another instance of <code>ServiceImpl</code> if the second
	 * binding is qualified by an annotation as in the previous example.  Gunk is
	 * not overly concerned with <i>preventing</i> you from creating multiple
	 * instances of your "singletons", only with <i>enabling</i> your application to
	 * share only one instance if that's all you tell Gunk you need.
	 *
	 * <p><b>Note:</b> a scope specified in this way <i>overrides</i> any scope that
	 * was specified with an annotation on the <code>ServiceImpl</code> class.
	 * 
	 * <listing>
	 *     bind(Service).toInstance(new ServiceImpl());
	 *     // or, alternatively
	 *     bind(Service).toInstance(SomeLegacyRegistry.getService());
	 * </listing>
	 *
	 * In this example, your module itself, <i>not Gunk</i>, takes responsibility
	 * for obtaining a <code>ServiceImpl</code> instance, then asks Gunk to always use
	 * this single instance to fulfill all <code>Service</code> injection requests.  When
	 * the Injector is created, it will automatically perform field
	 * and method injection for this instance, but any injectable constructor on
	 * <code>ServiceImpl</code> is simply ignored.  
	 *
	 * <listing>
	 *     bind(Service)
	 *         .annotatedWith(Names.named("blue"))
	 *         .to(BlueService);
	 * </listing>
	 *
	 * Differentiating by names is a common enough use case that we provided a
	 * standard annotation, [Named].  Remember that these
	 * names will live in a single flat namespace with all the other names used in
	 * your application.
	 *
	 * <p>The above list of examples is far from exhaustive.  If you can think of
	 * how the concepts of one example might coexist with the concepts from another,
	 * you can most likely weave the two together.  If the two concepts make no
	 * sense with each other, you most likely won't be able to do it.  In a few
	 * cases Gunk will let something bogus slip by, and will then inform you of
	 * the problems at runtime, as soon as you try to create your Injector.
	 *
	 * <p>The other methods of Binder such as bindAnnotationFactory and install 
	 * are not part of the Binding EDSL; you can learn how to use these in the 
	 * usual way, from the method documentation.
	 *
	 * @author crazybob@google.com (Bob Lee)
	 * @author jessewilson@google.com (Jesse Wilson)
	 * @author kevinb@google.com (Kevin Bourrillion)
	 * @author eecolor@gmail.com (Erik Westra)
	 * 
	 * @see ee.gunk.IInjector
	 * @see ee.gunk.IModule
	 * @see ee.gunk.AbstractModule
	 * @see ee.gunk.IProvider
	 * @see ee.gunk.Scope
	 */
	public interface IBinder
	{
		/**
		 * Binds a type
		 */
		function bind(type:Class):IAnnotatedBindingBuilder;
		
		/**
		 * Binds a key
		 */
		function bindKey(key:IKey):ILinkedBindingBuilder;
		
		/**
		 * Binds an annotation factory. This could be necessary for more complext annotations.
		 * <p/>
		 * By default an internal annotation factory is used. If a construction with metadata 
		 * is requested it will use one of the following signatures based on the number of 
		 * arguments in the constructor:
		 * 
		 * <listing>
		 * 	new Annotation();
		 * 	new Annotation(annotationMetadata.defaultValue);
		 * 	new Annotation(annotationMetadata.defaultValue, annotationMetadata.values);
		 * </listing>
		 * 
		 * @see ee.gunk.metadata.AnnotationMetadata
		 */
		function bindAnnotationFactory(annotationType:Class, annotationFactory:IAnnotationFactory):void;
		
		/**
		 * Use the given module to install bindings.
		 */
		function install(module:IModule):void;
	}
}