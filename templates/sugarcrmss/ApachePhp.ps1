Configuration InstallApachePhp 
{
	Node "localhost"
	{
		Script DownloadVisualCpp
	    {
	        TestScript = {
	            Test-Path "C:\WindowsAzure\vc_redist.x64.exe"
	        }
	        SetScript ={
	            $source = "https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe"
	            $dest = "C:\WindowsAzure\vc_redist.x64.exe"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "DownloadVisualCpp"}}
	    }
		Package InstallVisualCpp
	    {
	        Ensure = "Present"  
	        Path  = "C:\WindowsAzure\vc_redist.x64.exe"
	        Name = "Microsoft Visual C++ 2015 Redistributable Update 3"
	        ProductId = "{50A2BC33-C9CD-3BF1-A8FF-53C10A0B183C}"
	        Arguments = "/install /passive /quiet /norestart"
	        DependsOn = "[Script]DownloadVisualCpp"
	    }
	    Script DownloadApacheHttpd
	    {
	        TestScript = {
	            Test-Path "C:\WindowsAzure\httpd-2.4.25-win64-VC14.zip"
	        }
	        SetScript ={
	            $source = "http://www.apachelounge.com/download/VC14/binaries/httpd-2.4.25-win64-VC14.zip"
	            $dest = "C:\WindowsAzure\httpd-2.4.25-win64-VC14.zip"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "DownloadApacheHttpd"}}
	        DependsOn = "[Package]InstallVisualCpp"
	    }
	    Archive UnzipApacheHttpd {
		    Ensure = "Present"  
		    Path = "C:\WindowsAzure\httpd-2.4.25-win64-VC14.zip"
		    Destination = "C:\Apache24"
		    DependsOn = "[Script]DownloadApacheHttpd"
		} 
	    

	}
}