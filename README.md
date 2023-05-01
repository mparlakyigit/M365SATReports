# M365SATReports (BETA) 
Microsoft 365 Security Assessment Reports PowerShell betiği Microsoft 365 organizasyonu içerisinde güvenlik değerlendirmesi yaparak yapınızı daha iyi bir şekilde sıkılaştırmanızı sağlamaktadır. 

# Microsoft 365 Security Assessment Reports Hangi Başlıklara bakmaktadır ? 

- Disable Multifactor Authentication Users
- Global Admin Users
- User Password Expried
- DKIM Signature
- SPF Record
- Forwarding Users
- Mailboxes Members and Permissions
- Shared Mailboxes Members and Permissions
- Shared Mailboxes Members Block Credential
- External Sharing Calender Status
- Hosted Outbound Spam Filter Policy
- Bulk Threshold
- Outbound Connector
- Inbound Connector
- Domain & E-mail WhiteList
- IP Adress Allow List
- Remote Domain Auto Forward
- Transport Rules State
- Transport Rules WhiteList
- Transport Rules Forwarding
- Audit Bypass Enabled Users
- Enable File Filter
- Audit Log Search Status
- Modern Authentication Status

# Microsoft 365 Security Assessment Reports Nasıl çalışır ? 

![2023-04-29_22-48-40](https://user-images.githubusercontent.com/53214224/235321553-f3ae67a9-d1f9-401f-8f43-55674bc0207d.png)

- Öncelikle PowerShell yönetici olarak çalıştıralım.
- PowerShell üzerinde M365SATReports indirdiğimimiz PowerShell betiğinin bulunduğu dizine geçelim.
- PowerShell betiğimizi .\M365SATReports.ps1 şeklinde çalıştıralım.
- PowerShell betiğimiz bizden Global Admin kullanıcı bilgilerimizi, Kullanıcımıza ait parola ve son olarak kullandığımız domain adresini isteyecektir. 
- Bu işlemlerden sonra biraz bekliyerek raporumuz oluşacaktır. (Bu işlemin süresi kullanıcı sayımızın fazlalığına göre değişiklik gösterecektir.) Rapor otomartik olarak mevcut tarayıımızda açılacaktır.

Not : PowerShell betiği işlemini bitirdikten sonra rapor açılmazsa betiği çalıştırdığımız dizin içerisinde M365SATReports.html adında bir rapor oluşturacaktır. Çift tıklayarak açabiliriz. 

# Microsoft 365 Security Assessment Reports HTML Çıktı Örneği;

![2023-04-29_22-09-41](https://user-images.githubusercontent.com/53214224/235320188-704e69c4-9955-45a3-b57d-14051984afd8.png)
![Fs3MHg8XoAAjioG](https://user-images.githubusercontent.com/53214224/235319862-85c2c4b2-8c24-4b86-8bc8-d9b87f4531eb.jpeg)
