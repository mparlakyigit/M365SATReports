clear

Write-Host "Mehmet PATLAKYIGIT | Office Apps & Services MVP" -ForegroundColor blue
Write-Host "https://www.parlakyigit.net/" -ForegroundColor blue
Write-Host "Twitter:@mparlakyigit" -ForegroundColor blue
Write-Host "- Microsoft 365 | Security Assessment Reports (M365SAR) Beta -" -ForegroundColor red
Write-Host "Açıklama : Microsoft 365 Security Assessment Reports PowerShell betiği Microsoft 365 organizasyonu içerisinde güvenlik değerlendirmesi yaparak yapınızı daha iyi bir şekilde sıkılaştırmanızı sağlamaktadır." -ForegroundColor White
Write-Host ("+" * 50)

$username = Read-Host -Prompt "Global Admin User Name"
Read-Host -Prompt "Admin Password" -AsSecureString | ConvertFrom-SecureString | Out-File "./credential.txt"
$Password = Get-Content "./credential.txt" | ConvertTo-SecureString
$domainname = Read-Host -Prompt "Domain Name (contoso.com)"
$orgname = Read-Host -Prompt "SharePoint Org Name (contoso-admin.sharepoint.com)"
$cred = New-Object System.Management.Automation.PSCredential ($username,$Password)


#Connections
Set-ExecutionPolicy Unrestricted
Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -Credential $cred
Install-Module MSOnline
Import-Module MSOnline
Connect-MsolService -Credential $cred
Install-Module -Name AzureAD
Import-Module AzureAD
Connect-AzureAD -Credential $cred
Install-Module -Name Microsoft.Online.SharePoint.PowerShell 
Connect-SPOService -Credential $cred -Url https://$orgname-admin.sharepoint.com -ModernAuth $true -AuthenticationUrl https://login.microsoftonline.com/organizations


    $header=@"

<style>
h1 {color:Tomato} 
h2 {color:green}
h3 {color:red}
h4 {color:blue}
h5 {color:orange}

h2 {text-align: center;}
 


table {
  border-collapse: collapse;
  width: 70%;
  margin-left:auto; 
margin-right:auto;

}
th, td {
  padding: 8px;
  text-align: left;
  border-bottom: 0px solid #ddd;
}
tr:hover {background-color:#f5f5f5;}




TABLE {
	border-collapse: collapse;
    font-family: Tahoma, Geneva, sans-serif;
}
table td {
	padding: 15px;
}
table thead td {
	background-color: #54585d;
	color: #ffffff;
	font-weight: bold;
	font-size: 13px;
	border: 0px solid #54585d;
}
table tbody td {
	color: #636363;
	border: 0px solid #dddfe1;
}
table tbody tr {
	background-color: #f9fafb;
}
table tbody tr:nth-child(odd) {
	background-color: #ffffff;
}

</style>

 
<!DOCTYPE html>
<html>
<head>
   <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js'></script>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T' crossorigin='anonymous'>
    <title>Microsoft 365 | Security Assessment Reports</title>
    <link rel="icon" href="https://www.parlakyigit.net/wp-content/uploads/2023/01/M365Logo.png" sizes="192x192" />
</head>
<body>
<table width="845" height="66" border="0">
  <tr>
    <td width="141"><img alt="" src="https://www.parlakyigit.net/wp-content/uploads/2023/01/M365Logo.png" /></td>
    <td width="0"><strong><h1>Microsoft 365 | Security Assessment Reports (M365SAR) Beta</h1></strong></td>
  </tr>
  </table>
</body>
</html>


"@


$MsolCompanyInformation=Get-MsolCompanyInformation | Select-Object DisplayName,@{Name="TechnicalNotificationEmails";Expression={$_.TechnicalNotificationEmails -join "`r`n"}},TelephoneNumber | ConvertTo-Html -As Table -PreContent '<h2>Organization information</h2>' | Out-String

$MFAReport=Get-MsolUser -All | Where-Object {$_.StrongAuthenticationMethods.Count -eq 0 -and $_.BlockCredential -eq $False} | Select-Object -Property DisplayName,UserPrincipalName | ConvertTo-Html -As Table -PreContent '<h2>Disable Multifactor Authentication Users</h2>' | Out-String
#https://learn.microsoft.com/tr-tr/azure/active-directory/authentication/howto-mfa-reporting


$aciklama_bir=echo 1 | ConvertTo-Html -As Table -PreContent '<table border=0 cellspacing=0 cellpadding=0 align="center" width="100%">
  
  <br><tr>
    <td style="background:#00A0d2;padding:5pt 2pt 5pt 2pt"></td>
    <td width="100%" cellpadding="7px 6px 7px 15px" style="background:#e5f5fa;padding:5pt 4pt 5pt 12pt;word-wrap:break-word">
      <div style="color:#222222;">
        <span style="color:#222; font-weight:bold;">Açıklama:</span>
        MFA Kullanmayan kullanıcılar organizasyonunuz için tehlike oluşturmaktadır.
      </div>
    </td>
  </tr>
</table>
<br/>' | Out-String

$GetMsolRoleMember=Get-MsolRoleMember -RoleObjectId $(Get-MsolRole -RoleName "Company Administrator").ObjectId | select DisplayName, EmailAddress | ConvertTo-Html -As Table -PreContent '<h2>Global Admin Users</h2>' | Out-String

$ExtUsers=Get-MSOLUser -All | where {$_.UserType -eq "Guest"} | Select-Object DisplayName, UserPrincipalName, @{Name="AlternateEmailAddresses";Expression={$_.AlternateEmailAddresses -join "`r`n"}} | ConvertTo-Html -As Table -PreContent '<h2>External Users</h2>' | Out-String

$MsolPasswordPolicy=Get-MsolPasswordPolicy -DomainName $domainname | select NotificationDays,ValidityPeriod | ConvertTo-Html -As Table -Fragment -PreContent '<h2>User Password Expried</h2>' | Out-String

$GetDkim=Get-DkimSigningConfig | Where-Object {$_.name -notlike "*.onmicrosoft.com"} | select Domain,Enabled,Selector1CNAME,Selector2CNAME | ConvertTo-Html -As Table -Fragment -PreContent '<h2>DKIM Signature</h2>' | Out-String

$SPF=Get-MsolDomain | Where-Object {$_.name -notlike "*.onmicrosoft.com"} | Resolve-DnsName -Type txt | Where-Object {$_.Strings -match "v=spf1"} | Select-Object Name,@{Name="SPF Record";Expression={$_.Strings -join "`r`n"}} | ConvertTo-Html -As Table -PreContent '<h2>SPF Record</h2>' | Out-String

$ForwardingUsers=Get-Mailbox | Where {$null -ne $_.ForwardingSmtpAddress} | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | ConvertTo-Html -As Table -PreContent '<h2>Forwarding Users</h2>' | Out-String

$MailboxPer=Get-Mailbox | Where-Object {$_.RecipientTypeDetails -eq "UserMailbox"} | Get-MailboxPermission | Where-Object { $_.AccessRights -match "FullAccess" -and $_.IsInherited -eq $false -and $_.User.ToString().IndexOf("@") -gt 0 } | Select-Object Identity,User,AccessRights | ConvertTo-Html -As Table -PreContent '<h2>Mailboxes Members and Permissions</h2>' | Out-String


$SharedMailbox=Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Get-MailboxPermission | Where-Object { $_.AccessRights -match "FullAccess" -and $_.IsInherited -eq $false -and $_.User.ToString().IndexOf("@") -gt 0 } |Select-Object Identity,User,AccessRights | ConvertTo-Html -As Table -PreContent '<h2>Shared Mailboxes Members and Permissions</h2>' | Out-String


$blockcredential=Get-Mailbox -Filter {recipienttypedetails -eq "SharedMailbox"} | get-MsolUser | Where-Object  { $_.BlockCredential -eq $False } | Select-Object userprincipalname,blockcredential | ConvertTo-Html -As Table -PreContent '<h2>Shared Mailboxes Members Block Credential</h2>' | Out-String

$ExternalSharingCalender=Get-SharingPolicy -Identity 'Default Sharing Policy' | select Enabled,domains | ConvertTo-Html -As Table -PreContent '<h2>External Sharing Calender Status</h2>' | Out-String


$aciklama_yedi=echo 1 | ConvertTo-Html -As Table -PreContent '<table border=0 cellspacing=0 cellpadding=0 align="center" width="100%">
  
  <br><tr>
    <td style="background:#00A0d2;padding:5pt 2pt 5pt 2pt"></td>
    <td width="100%" cellpadding="7px 6px 7px 15px" style="background:#e5f5fa;padding:5pt 4pt 5pt 12pt;word-wrap:break-word">
      <div style="color:#222222;">
        <span style="color:#222; font-weight:bold;">Açıklama:</span>
        Shared Mailbox Web Üzerinden oturum açamaması gerekmektedir. False değerine sahip bir SharedMailbox oturum açabiliyor demektir. <br>https://www.parlakyigit.net/shared-mailbox-hesabi-icin-oturum-acmayi-engellemek/
      </div>
    </td>
  </tr>
</table>
<br/>' | Out-String

$HostedOutboundSpamFilterPolicy=Get-HostedOutboundSpamFilterPolicy | select Id,RecipientLimitExternalPerHour,RecipientLimitInternalPerHour,RecipientLimitPerDay,ActionWhenThresholdReached | ConvertTo-Html -As Table -Fragment -PreContent '<h2>Hosted Outbound Spam Filter Policy</h2>' | Out-String

$BulkThreshold=Get-HostedContentFilterPolicy Default | select Identity,BulkThreshold,QuarantineRetentionPeriod | ConvertTo-Html -As Table -PreContent '<h2>Bulk Threshold</h2>' | Out-String

$OutboundConnector=Get-OutboundConnector | select Identity,ConnectorType,Enabled | ConvertTo-Html -As Table -PreContent '<h2>Outbound Connector</h2>' | Out-String

$InboundConnector=Get-InboundConnector | select Identity,ConnectorType,Enabled,SenderIPAddresses | ConvertTo-Html -As Table -PreContent '<h2>Inbound Connector</h2>' | Out-String

$whitelist=Get-HostedContentFilterPolicy -Identity 'Default' | select Identity,AllowedSenderDomains,AllowedSenders | ConvertTo-Html -As Table -PreContent '<h2>Domain & E-mail WhiteList </h2>' | Out-String

$IPAllowList=Get-HostedConnectionFilterPolicy -Identity 'Default' | select Identity,IPAllowList | ConvertTo-Html -As Table -PreContent '<h2>IP Adress Allow List </h2>' | Out-String

$RemoteDomainAutoForward=Get-RemoteDomain Default | select Identity,AutoForwardEnabled | ConvertTo-Html -As Table -PreContent '<h2>Remote Domain Auto Forward </h2>' | Out-String

$TransportRule=Get-TransportRule * | select Name,State | ConvertTo-Html -As Table -PreContent '<h2>Transport Rules State </h2>' | Out-String

$TransportRulesWhiteList=Get-TransportRule | Where-Object { $_.SetSCL -AND ($_.SetSCL -as [int] -LE 0) -AND $_.SenderDomainIs } | Select-Object -Property Name,State,SenderDomainIs,SetSCL | ConvertTo-Html -As Table -PreContent '<h2>Transport Rules WhiteList </h2>' | Out-String

$TransportRulesForwarding=Get-TransportRule | Where-Object { $_.BlindCopyTo } | Select-Object -Property Name,State,SentTo,BlindCopyTo | ConvertTo-Html -As Table -PreContent '<h2>Transport Rules Forwarding </h2>' | Out-String

$AuditBypass=Get-MailboxAuditBypassAssociation -ResultSize unlimited | Where-Object {$_.AuditBypassEnabled -eq $True} | Select Name,AuditBypassEnabled | ConvertTo-Html -As Table -PreContent '<h2>Audit Bypass Enabled Users </h2>' | Out-String
#https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailboxauditbypassassociation?view=exchange-ps#examples
#https://learn.microsoft.com/en-us/powershell/module/exchange/set-mailboxauditbypassassociation?view=exchange-ps

$FileFilter=Get-MalwareFilterPolicy Default | select Name,EnableFileFilter,FileTypes | ConvertTo-Html -As Table -PreContent '<h2>Enable File Filter </h2>' | Out-String

$AdminAuditLogConfig=Get-AdminAuditLogConfig | select Name,UnifiedAuditLogIngestionEnabled | ConvertTo-Html -As Table -PreContent '<h2>Audit Log Search Status </h2>' | Out-String

$ModernAuth=Get-OrganizationConfig | Select Name,OAuth* | ConvertTo-Html -As Table -PreContent '<h2>Modern Authentication Status </h2>' | Out-String

$ExternalInOutlook=get-ExternalInOutlook | Select Enabled,AllowList | ConvertTo-Html -As Table -PreContent '<h2>Outlook External Sender Tag </h2>' | Out-String

$Des='<br><table width="827" border="0">
<tr>
    <td width="204" height="113"><img src="http://www.parlakyigit.net/wp-content/uploads/2017/04/MVP_Logo_Horizontal_Secondary_Blue288_CMYK_300ppi.png" width="308" height="124" align="left" /></td>
    <td width="0"><p>Mehmet PARLAKYİĞİT<br>
      M365 Apps & Services MVP<br>
      <a href="https://www.parlakyigit.net/">www.parlakyigit.net</a><br>
    @mparlakyigit</p></td>
  </tr>
</table>' | Out-String


$AzureADApplication= Get-AzureADApplication | Select DisplayName,ObjectId | ConvertTo-Html -As Table -PreContent '<h2>Azure AD Applications </h2>' | Out-String 

$SPOExtSharing= Get-SPOSite -Limit All | Where-Object {$_.SharingCapability -ne "Disabled"} | Select-Object Url, SharingCapability | ConvertTo-Html -As Table -PreContent '<h2>SharePoint Online External Sharing Sites </h2>' | Out-String

Convertto-html -PreContent $MsolCompanyInformation,$MFAReport,$aciklama_bir,$GetMsolRoleMember,$ExtUsers,$MsolPasswordPolicy,$GetDkim,$SPF,$ForwardingUsers,$MailboxPer,$SharedMailbox,$blockcredential,$aciklama_yedi,$ExternalSharingCalender,$HostedOutboundSpamFilterPolicy,$BulkThreshold,$OutboundConnector,$InboundConnector,$whitelist,$IPAllowList,$RemoteDomainAutoForward,$TransportRule,$TransportRulesWhiteList,$TransportRulesForwarding,$AuditBypass,$FileFilter,$AdminAuditLogConfig,$ExternalInOutlook,$ModernAuth,$AzureADApplication,$SPOExtSharing,$Des -Head $header | Out-File "./M365SATReports.html"



Invoke-Item ./M365SATReports.html
Remove-item ./credential.txt


