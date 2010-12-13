package by.blooddy.crypto
{
	
	import flash.utils.getTimer;
	
	import org.flexunit.assertThat;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.number.lessThan;
	import org.hamcrest.object.equalTo;
	
	public class MD5Test
	{		
		[Test]
		public function testHash():void
		{
			assertThat(MD5.hash(""), equalTo("d41d8cd98f00b204e9800998ecf8427e"));
			assertThat(MD5.hash("a"), equalTo("0cc175b9c0f1b6a831c399e269772661"));
			assertThat(MD5.hash("abc"), equalTo("900150983cd24fb0d6963f7d28e17f72"));
			assertThat(MD5.hash("message digest"), equalTo("f96b697d7cb7938d525a2f31aaf161d0"));
			assertThat(MD5.hash("abcdefghijklmnopqrstuvwxyz"), equalTo("c3fcd3d76192e4007dfb496cca67e13b"));
			assertThat(MD5.hash("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"), equalTo("d174ab98d277d9f5a5611c2c9f419d9f"));
			assertThat(MD5.hash("12345678901234567890123456789012345678901234567890123456789012345678901234567890"), equalTo("57edf4a22be3c955ac49da2e2107b67a"));
		}
	}
}