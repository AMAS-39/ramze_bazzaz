# ramzebazzaz
 		814030042ACE7 /* Copy firebase configs */ = {
			isa = PBXShellScriptBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			inputFileListPaths = (
			);
			inputPaths = (
			);
			name = "Copy firebase configs";
			outputFileListPaths = (
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = "environment=\"default\"\n\n# Regex to extract the scheme name from the Build Configuration\n# We have named our Build Configurations as Debug-dev, Debug-prod etc.\n# Here, dev and prod are the scheme names. This kind of naming is required by Flutter for flavors to work.\n# We are using the $CONFIGURATION variable available in the XCode build environment to extract \n# the environment (or flavor)\n# For eg.\n# If CONFIGURATION=\"Debug-prod\", then environment will get set to \"prod\".\nif [[ $CONFIGURATION =~ -([^-]*)$ ]]; then\nenvironment=${BASH_REMATCH[1]}\nfi\n\necho $environment\n\n# Name and path of the resource we're copying\nGOOGLESERVICE_INFO_PLIST=GoogleService-Info.plist\nGOOGLESERVICE_INFO_FILE=${PROJECT_DIR}/config/${environment}/${GOOGLESERVICE_INFO_PLIST}\n\n# Make sure GoogleService-Info.plist exists\necho \"Looking for ${GOOGLESERVICE_INFO_PLIST} in ${GOOGLESERVICE_INFO_FILE}\"\nif [ ! -f $GOOGLESERVICE_INFO_FILE ]\nthen\necho \"No GoogleService-Info.plist found. Please ensure it's in the proper directory.\"\nexit 1\nfi\n\n# Get a reference to the destination location for the GoogleService-Info.plist\n# This is the default location where Firebase init code expects to find GoogleServices-Info.plist file\nPLIST_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app\necho \"Will copy ${GOOGLESERVICE_INFO_PLIST} to final destination: ${PLIST_DESTINATION}\"\n\n# Copy over the prod GoogleService-Info.plist for Release builds\ncp \"${GOOGLESERVICE_INFO_FILE}\" \"${PLIST_DESTINATION}\"\n";
		};
		814030042ACE7 /* Copy Firebase App Id */ = {
			isa = PBXShellScriptBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			inputFileListPaths = (
			);
			inputPaths = (
			);
			name = "Copy Firebase App Id";
			outputFileListPaths = (
			);
			outputPaths = (
			);
			runOnlyForDeploymentPostprocessing = 0;
			shellPath = /bin/sh;
			shellScript = " environment=\"default\"\n \n # Regex to extract the scheme name from the Build Configuration\n # We have named our Build Configurations as Debug-dev, Debug-prod etc.\n # Here, dev and prod are the scheme names. This kind of naming is required by Flutter for flavors to work.\n # We are using the $CONFIGURATION variable available in the XCode build environment to extract \n # the environment (or flavor)\n # For eg.\n # If CONFIGURATION=\"Debug-prod\", then environment will get set to \"prod\".\n if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then\n environment=${BASH_REMATCH[1]}\n fi\n \n echo $environment\n \n # Name and path of the resource we're copying\n FIREBASEPPID_INFO_PLIST=firebase_app_id_file.json\n FIREBASEPPID_INFO_FILE=${PROJECT_DIR}/config/${environment}/${FIREBASEPPID_INFO_PLIST}\n \n # Make sure firebase_app_id_file.json exists\n echo \"Looking for ${FIREBASEPPID_INFO_PLIST} in ${FIREBASEPPID_INFO_FILE}\"\n if [ ! -f $FIREBASEPPID_INFO_FILE ]\n then\n echo \"No firebase_app_id_file.json found. Please ensure it's in the proper directory.\"\n exit 1\n fi\n \n # Get a reference to the destination location for the firebase_app_id_file.json\n # This is the default location of firebase_app_id_file.json file\n PLIST_DESTINATION=${PROJECT_DIR}\n echo \"Will copy ${FIREBASEPPID_INFO_PLIST} to final destination: ${PLIST_DESTINATION}\"\n \n # Copy over the prod firebase_app_id_file.json for Release builds\n cp \"${FIREBASEPPID_INFO_FILE}\" \"${PLIST_DESTINATION}\"\n";
		};
te