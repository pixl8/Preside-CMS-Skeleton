component extends="commandbox.system.BaseCommand" {

	public void function postInstall( required string directory ) {
		print.line();
		var siteId = ask( "Enter a site id (no spaces or special chars, e.g. amazon): " );
		while( !_validSlug( siteId ) ) {
			print.line();
			print.redLine( "Invalid site ID. Must contain only letters, numbers, - or _.");
			print.line();
			siteId   = ask( "Enter a site ID (no spaces or special chars, e.g. amazon): " );
		}

		var adminPath = ask( "Enter an admin URL path (no spaces or special chars, e.g. amazon_admin): " );
		while( !_validSlug( adminPath ) ) {
			print.line();
			print.redLine( "Invalid admin URL path. Must contain only letters, numbers, - or _.");
			print.line();
			adminPath = ask( "Enter an admin URL path (no spaces or special chars, e.g. amazon_admin): " );
		}

		var appName = ask( "Enter an site name (e.g. Amazon.com): " );
		while( !Len(Trim( appName ) ) ) {
			appName = ask( "Enter an site name (e.g. Amazon.com): " );
		}

		var author = ask( "Enter the site author (e.g. Super L33t Software co.): " );
		while( !Len(Trim( author ) ) ) {
			author = ask( "Enter the site author (e.g. Super L33t Software co.): " );
		}

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