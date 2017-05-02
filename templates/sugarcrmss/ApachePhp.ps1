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
	    

	}
}