component extends="preside.system.config.Config" output=false {

	public void function configure() output=false {
		super.configure();

		settings.preside_admin_path         = "${admin_path}";
		settings.system_user                = "sysadmin";
		settings.default_locale             = "en";

		settings.default_log_name           = "${site_id}";
		settings.default_log_level          = "information";
		settings.sql_log_name               = "${site_id}";
		settings.sql_log_level              = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );
		
		settings.features.websiteUsers.enabled = false;
	}
}
