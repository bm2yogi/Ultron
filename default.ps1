properties {
    $appName = $appName
}

Task Default -depends Build, SetupIIS

Task Build {
   Exec { msbuild  /p:DeployOnBuild=true /p:PublishProfile=Local}
}

Task SetupIIS {
    Import-Module WebAdministration
    
    $appPoolName = $appName + "Pool"
    $appPoolDotNetVersion = "v4.0"
    $directoryPath = "C:\inetpub\wwwroot\$appName"

    pushd IIS:\AppPools\

    if (!(Test-Path $appPoolName -pathType container))
    {
        $appPool = New-Item $appPoolName
        $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $appPoolDotNetVersion
    }
    
    popd
    pushd IIS:\Sites\
    
    if (Test-Path $appName -pathType container)
    {
        return
    }

    $app = New-Item $appName -bindings @{protocol="http";bindingInformation=":80:" + $appName} -physicalPath $directoryPath
    $app | Set-ItemProperty -Name "applicationPool" -Value $appPoolName
    
    popd
}