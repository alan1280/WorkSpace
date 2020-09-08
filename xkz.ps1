#定义变量
##缓存账户凭据：
$credential = Get-Credential xxx@xxxx.com
##需按照许可证订阅查询
$sku01 = 许可证名称01
$sku02 = 许可证名称02
$sku03 = 许可证名称03
$sku04 = 许可证名称04
##配置禁用功能列表
$P1 = New-MsolLicenseOptions -AccountSkuId "$sku01" -DisabledPlans "KAIZALA_O365_P3","Deskless","SWAY","FLOW_O365_P2"
$P2 = New-MsolLicenseOptions -AccountSkuId "$sku01" -DisabledPlans "KAIZALA_O365_P3","Deskless","SWAY","FLOW_O365_P2"
$P3 = New-MsolLicenseOptions -AccountSkuId "$sku01" -DisabledPlans "KAIZALA_O365_P3","Deskless","SWAY","FLOW_O365_P2"
$P4 = New-MsolLicenseOptions -AccountSkuId "$sku01" -DisabledPlans "KAIZALA_O365_P3","Deskless","SWAY","FLOW_O365_P2"
## 由于对应表的可阅读性较差，可进行如下参考配置：
## 首先配置一个范例账户，完善好组件及产品，使用命令导出配置表，生成配置计划$Plan。
###(Get-MsolUser -UserPrincipalName xxx@xxx.com).Licenses.ServiceStatus


#设置Powershell 安全项
Set-ExecutionPolicy RemoteSigned

#加载Office 365模块
Install-Module -Name MSOnline

#Connect to Azure AD for your Microsoft 365 subscription
Connect-MsolService -Credential $credential

#设置用户归属地域为 CN
Get-MsolUser -All | where {$_.UsageLocation -eq $null} | Set-MsolUser -UsageLocation CN

#查看当前许可证订阅情况：（格式类似：许可证类型：数量：已使用数量）
Get-MsolAccountSku

#查看当前订阅许可列表
#(Get-MsolAccountSku | where {$_.AccountSkuId -eq '<AccountSkuId>'}).ServiceStatus


# 依据csv启用用户许可证 SKU01 全功能
##User.txt 一列，标头为UPNname。
Import-Csv c:\users.txt | foreach {Set-MsolUserLicense -UserPrincipalName $_.UPNname -AddLicenses "$sku01" }
# 依据csv启用用户许可证 SKU01 许可证中特定功能列表01
##User.txt 一列，标头为UPNname。
Import-Csv c:\users01.txt | foreach {Set-MsolUserLicense -UserPrincipalName $_.UPNname -AddLicenses "$sku01" -LicenseOptions $P1 }
