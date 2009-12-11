package library {
	import Assets;
	
       /**
        * @author sebastiandeutsch
        *
        */
       public class Asset {
       public static function create( name:String ):* {
               if(Assets[name] != null) {
               		return new Assets[name]();
               }
           }
       }
}