component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory ) {
		print.boldLine( "CMS Website setup wizard" );
		print.boldLine( "========================" );
		print.line();
		print.line( "You're nearly there. Answer a few questions and we'll get your new site setup and ready to go :)" );
		print.line().toConsole();

		var adminPath = "";
		var siteId    = "";
		var appName   = "";
		var author    = "";

		while( !Len(Trim( appName ) ) ) {
			appName = ask( "Enter a site title (e.g. My Cool Site): " );
		}
		while( !Len(Trim( author ) ) ) {
			author = ask( "Enter the site author (e.g. Super L33t Software co.): " );
		}

		do {
			siteId = ask( message="Enter a unique site ID (no spaces or special chars, e.g. my-cool-site): " )
			if ( !_validSlug( siteId ) ) {
				siteId = "";
				print.line();
				print.redLine( "Invalid site ID. Must contain only letters, numbers, - or _.");
				print.line();
			}
		} while( !Len( siteId ) );

		do {
			adminPath = ask( message="Enter an admin URL path (no spaces or special chars, e.g. admin) ", defaultResponse="admin" )
			if ( !_validSlug( adminPath ) ) {
				adminPath = "";
				print.line();
				print.redLine( "Invalid admin URL path. Must contain only letters, numbers, - or _.");
				print.line();
			}
		} while( !Len( adminPath ) );

		print.greenLine( "");
		print.greenLine( "Thank you. Finalizing your template now..." );

		var configCfcPath       = arguments.directory & "/application/config/Config.cfc";
		var appCfcPath          = arguments.directory & "/Application.cfc";
		var boxJsonPath         = arguments.directory & "/box.json";
		var boxJsonTemplatePath = arguments.directory & "/box.json.template";
		var config              = FileRead( configCfcPath       );
		var appcfc              = FileRead( appCfcPath          );
		var boxjson             = FileRead( boxJsonTemplatePath );

		config  = ReplaceNoCase( config , "${site_id}", siteId, "all" );
		config  = ReplaceNoCase( config , "${admin_path}", adminPath, "all" );
		appcfc  = ReplaceNoCase( appcfc , "${site_id}", siteId, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_name}', appName, "all" );
		boxjson = ReplaceNoCase( boxjson, '${site_id}', siteId, "all" );
		boxjson = ReplaceNoCase( boxjson, '${author}', author, "all" );

		FileWrite( configCfcPath, config );
		FileWrite( appCfcPath   , appcfc );
		FileWrite( boxJsonPath  , boxjson );
		FileDelete( boxJsonTemplatePath );

		print.greenLine( "" );
		print.greenLine( "Installing the latest stable Preside release..." );
		print.greenLine( "" );
		getInstance( "packageService" ).installPackage(
			  id                      = "presidecms"
			, save                    = true
			, saveDev                 = false
			, production              = true
		);
	}

	private boolean function _validSlug( required string slug ) {
		return ReFindNoCase( "^[a-z0-9-_]+$", arguments.slug );
	}
}