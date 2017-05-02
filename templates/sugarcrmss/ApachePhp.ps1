Configuration InstallApachePhp 
{
	Node "localhost"
	{
		Script DownloadVisualCpp
	    {
	        TestScript = {
	            Test-Path "C:\WindowsAzure\vcredist_x64.exe"
	        }
	        SetScript ={
	            $source = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
	            $dest = "C:\WindowsAzure\vcredist_x64.exe"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "DownloadVisualCpp"}}
	    }
	    Package InstallVisualCpp
	    {
	        Ensure = "Present"  
	        Path  = "C:\WindowsAzure\vcredist_x64.exe"
	        Name = "Microsoft Visual C++ 2012 Redistributable (x64) - 11.0.61030"
	        ProductId = "{CF2BEA3C-26EA-32F8-AA9B-331F7E34BA97}"
	        Arguments = "/install /passive /quiet /norestart"
	        DependsOn = "[Script]DownloadVisualCpp"
	    }
	    Script DownloadApacheHttpd
	    {
	        TestScript = {
	            Test-Path "C:\WindowsAzure\httpd-2.4.25-win64-VC11.zip"
	        }
	        SetScript ={
	            $source = "http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.25-win64-VC11.zip"
	            $dest = "C:\WindowsAzure\httpd-2.4.25-win64-VC11.zip"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "DownloadApacheHttpd"}}
	        DependsOn = "[Package]InstallVisualCpp"
	    }
	    Archive UnzipApacheHttpd {
		    Ensure = "Present"  
		    Path = "C:\WindowsAzure\httpd-2.4.25-win64-VC11.zip"
		    Destination = "C:\"
		    DependsOn = "[Script]DownloadApacheHttpd"
		} 
		Script DownloadPHP
	    {
	        TestScript = {
	            Test-Path "C:\WindowsAzure\php-5.6.30-Win32-VC11-x64.zip"
	        }
	        SetScript = {
	            $source = "http://windows.php.net/downloads/releases/php-5.6.30-Win32-VC11-x64.zip"
	            $dest = "C:\WindowsAzure\php-5.6.30-Win32-VC11-x64.zip"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "DownloadPHP"}}
	        DependsOn = "[Archive]UnzipApacheHttpd"
	    }
	    Archive UnzipPHP{
		    Ensure = "Present"  
		    Path = "C:\WindowsAzure\php-5.6.30-Win32-VC11-x64.zip"
		    Destination = "C:\php"
		    DependsOn = "[Script]DownloadPHP"
		}   
		Script UpdateHttpdConf
	    {
	        TestScript = {
	            Test-Path "C:\Apache24\conf\httpd.conf"
	        }
	        SetScript = {
	        	$source = "https://raw.githubusercontent.com/Marvel77/sample-dsc/master/templates/sugarcrmss/conf/httpd.conf"
	            $dest = "C:\Apache24\conf\httpd.conf"
	            Invoke-WebRequest $source -OutFile $dest
	        }
	        GetScript = {@{Result = "UpdateHttpdConf"}}
	        DependsOn = "[Archive]UnzipPHP"
	    }

	}
}