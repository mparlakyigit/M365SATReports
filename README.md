# M365SAReports (BETA) English
The Microsoft 365 Security Assessment Reports PowerShell script enables you to assess the security of your organization within Microsoft 365 and helps you tighten your structure.

Note: Our M365SATReports PowerShell script is currently in the BETA stage. The script will continue to be developed. After I make updates and improvements, you can download the updated version at specific intervals from GitHub and run it again. This way, you will encounter different results every time you run M365SATReports.

Note: M365SATReport recommends periodically checking and running the latest version. Over time, you can assess the Security Assessment status of your organization and ensure that your environment is tightened in terms of security.

# Which headings does Microsoft 365 Security Assessment Reports look at?

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

# How does Microsoft 365 Security Assessment Reports work?

![2023-04-29_22-48-40](https://user-images.githubusercontent.com/53214224/235321553-f3ae67a9-d1f9-401f-8f43-55674bc0207d.png)

- First, let's run PowerShell as an administrator.
- Switch to the directory where we downloaded the M365SATReports PowerShell script in PowerShell.
- Run our PowerShell script as .\M365SATReports.ps1.
- Our PowerShell script will ask for our Global Admin user information, our user's password, and finally, the domain address we are using.
- After these steps, our report will be generated after a while. (The duration of this process will vary depending on the number of users we have.) The report will automatically open in our default browser.

Note: Make sure the user you will perform the process on has Global Admin and Exchange Admin privileges before running it.

Note: If the report does not open after completing the PowerShell script, a report named M365SATReports.html will be created in the directory where we ran the script. We can open it by double-clicking

# Example HTML output of Microsoft 365 Security Assessment Reports

![2023-04-29_22-09-41](https://user-images.githubusercontent.com/53214224/235320188-704e69c4-9955-45a3-b57d-14051984afd8.png)
![Fs3MHg8XoAAjioG](https://user-images.githubusercontent.com/53214224/235319862-85c2c4b2-8c24-4b86-8bc8-d9b87f4531eb.jpeg)

# M365SAReports (BETA) Tükçe Anlatım
Microsoft 365 Security Assessment Reports PowerShell betiği Microsoft 365 organizasyonu içerisinde güvenlik değerlendirmesi yaparak yapınızı daha iyi bir şekilde sıkılaştırmanızı sağlamaktadır. 

Not : M365SATReports PowerShell betiğimiz BETA aşamasındadır. Betik geliştirilmeye devam edecektir. Yaptığım güncellemeler ve geliştirmeler sonrası yine GitHub üzerinden belirli aralıklarla güncellenmiş halini indirerek çalıştırabilirsiniz. Böylelikle M365SATReports her çalıştırdığınızda farklı sonuçlarla karşılaşacaksınız. 

Not : M365SATReport periyodik olarak belirli aralıklarla güncel sürümü kontrol edip çalıştırmanızı öneririrm. Zaman içerisinde organizasyonunuzun  Security Assessment durumunu değerlendirmenizi ve ortamınızın güvenlik bakımından sıkılaştırılmasını sağlamış olursunuz. 

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

Not : İşlemi yapacağınız kullanıcıda Global Admin ve Exchange Admin yetkisi olduğundan emin olduktan sonra çalıştırınız. 

Not : PowerShell betiği işlemini bitirdikten sonra rapor açılmazsa betiği çalıştırdığımız dizin içerisinde M365SATReports.html adında bir rapor oluşturacaktır. Çift tıklayarak açabiliriz. 

# Microsoft 365 Security Assessment Reports HTML Çıktı Örneği;

![2023-04-29_22-09-41](https://user-images.githubusercontent.com/53214224/235320188-704e69c4-9955-45a3-b57d-14051984afd8.png)
![Fs3MHg8XoAAjioG](https://user-images.githubusercontent.com/53214224/235319862-85c2c4b2-8c24-4b86-8bc8-d9b87f4531eb.jpeg)
