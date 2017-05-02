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
	   
	    

	}
}