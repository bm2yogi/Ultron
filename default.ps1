properties {
    $appName = $appName
    $appPath = "\inetpub\wwwroot\" + $appName
    $projectPath = ".\"
    $unitTestPath = $projectPath + "Tests.Unit\bin\Debug\Tests.Unit.dll"
}

Task Default -depends Build, Test, SetupIIS

Task Clean {
    if (Test-Path $appPath){
        Exec { del $appPath -Recurse }
    }
}

Task Build -depends Clean {
   Exec { & msbuild  /p:VisualStudioVersion=12.0 /p:DeployOnBuild=true /p:PublishProfile=Local}
}

Task Test -depends Build {
    $nUnitPath = ".\packages\NUnit.ConsoleRunner.3.2.1\tools"
    Exec { & $nUnitPath\nunit3-console.exe $unitTestPath }
}

Task Analyze { 
    Exec { Echo "Analyze" } 
}

Task Package { Exec { Echo "Package" } }

Task Deploy {
    #$paths = "Areas","bin","Content","fonts","Scripts","Views","favicon.ico","web.config","Global.asax","packages.config";
    #Exec { mkdir $appPath }
    #Exec { echo "$appName\Areas" }
    #Exec { $paths | % {xcopy /SY "$appName\$_" $appPath} }
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