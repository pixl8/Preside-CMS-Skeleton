/**
 * Sticker bundle configuration file. See: http://sticker.readthedocs.org/
 */

component output=false {

	public void function configure( bundle ) output=false {

		bundle.addAssets(
			  directory   = "/"
			, match       = function( filepath ){ return ReFindNoCase( "\.(js|css)$", filepath ); }
			, idGenerator = function( filepath ){
				var fileName = ListLast( filePath, "/" );
				var id       = ListLast( filename, "." ) & "-" & ReReplace( filename, "\.(js|css)$", "" );
				return id;
			  }
		);

		bundle.asset( "css-bootstrap" ).before( "*" );
		bundle.asset( "js-bootstrap" ).dependsOn( "js-jquery" );
	}
}