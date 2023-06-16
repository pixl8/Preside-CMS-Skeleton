component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory ) {
		print.line();
		print.boldLine( "===================================" );
		print.boldLine( "Preside Empty Skeleton setup wizard" );
		print.boldLine( "===================================" );
		print.line();
		print.line( "You're nearly there. Answer a few questions and we'll get your new site setup and ready to go :)" );
		print.line().toConsole();

		var appName   = "";
		var siteId    = "";

		while( !Len(Trim( appName ) ) ) {
			appName = ask( "Enter a name for your site (e.g. My Cool Site): " );
		}

		siteId = LCase( ReReplace( appName, "\w", "-", "all" ) );
		siteId = ReReplace( appName, "-+", "-", "all" );
		siteId = ReReplace( appName, "^-+", "" );
		siteId = ReReplace( appName, "-+$", "" );

		print.line( "");
		print.greenLine( "Thank you. Finalizing your template now. NOTE: your admin path is set to /admin/." );
		print.line( "");

		var configCfcPath       = arguments.directory & "/application/config/Config.cfc";
		var appCfcPath          = arguments.directory & "/Application.cfc";
		var boxJsonPath         = arguments.directory & "/box.json";
		var boxJsonTemplatePath = arguments.directory & "/box.json.template";
		var config              = FileRead( configCfcPath       );
		var appcfc              = FileRead( appCfcPath          );
		var boxjson             = FileRead( boxJsonTemplatePath );

		config  = ReplaceNoCase( config , "${site_id}", siteId, "all" );
		appcfc  = ReplaceNoCase( appcfc , "${site_id}", siteId, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_name}', appName, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_id}', siteId, "all" );

		FileWrite( configCfcPath, config );
		FileWrite( appCfcPath   , appcfc );
		FileWrite( boxJsonPath  , boxjson );
		FileDelete( boxJsonTemplatePath );

		print.greenLine( "" );
		print.greenLine( "Installing the latest stable Preside release..." );
		print.greenLine( "" );

		command( "install" ).params( "presidecms" ).run();
		command( "install" ).params( "preside-ext-launcher" ).run();
		command( "install" ).params( "preside-ext-alt-admin-theme" ).run();
	}

	private boolean function _validSlug( required string slug ) {
		return ReFindNoCase( "^[a-z0-9-_]+$", arguments.slug );
	}
}