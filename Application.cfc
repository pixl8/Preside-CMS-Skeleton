component extends="preside.system.Bootstrap" {

	// see /preside/system/Bootstrap.cfc$setupApplication()
	// for further options
	super.setupApplication(
		  id                       = "${site_id}"
		, presideSessionManagement = true
	);

}
