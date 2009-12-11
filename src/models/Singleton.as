
package models  
{

	public final class Singleton 
	{

		private static var instance : Singleton = new Singleton();

		
		public function Singleton() 
		{

			if( instance ) throw new Error("Singleton and can only be accessed through Singleton.getInstance()"); 
		}

		public static function getInstance() : Singleton 
		{

			return instance;
		}
	}
}