local L = LibStub("AceLocale-3.0"):NewLocale( "DataStore_Mails", "deDE" )

if not L then return end

L["EXPIRY_ALL_ACCOUNTS_DISABLED"] = "Nur der aktuelle Account wird berücksichtigt; importierte Accounts werden ignoriert."
L["EXPIRY_ALL_ACCOUNTS_ENABLED"] = "Die Überprüfungsroutine nach verfallender Post sucht auf allen bekannten Accounts nach Sendungen, die verfallen."
L["EXPIRY_ALL_ACCOUNTS_LABEL"] = "Verfallende Post bei allen bekannten Accounts überprüfen" -- Needs review
L["EXPIRY_ALL_ACCOUNTS_TITLE"] = "Alle Accounts überprüfen"
L["EXPIRY_ALL_REALMS_DISABLED"] = "Nur der aktuelle Realm wird berücksichtigt; andere Realms werden ignoriert."
L["EXPIRY_ALL_REALMS_ENABLED"] = "Die Überprüfungsroutine nach verfallender Post sucht auf allen bekannten Realms nach Sendungen, die verfallen."
L["EXPIRY_ALL_REALMS_LABEL"] = "Verfallende Post bei allen bekannten Realms überprüfen" -- Needs review
L["EXPIRY_ALL_REALMS_TITLE"] = "Alle Realms überprüfen"
L["EXPIRY_CHECK_DISABLED"] = "Es wird keine Überprüfung verfallender Post durchgeführt."
L["EXPIRY_CHECK_ENABLED"] = "Verfallende Post wird 5 Sekunden nach dem Einloggen überprüft. Client-Add-Ons erhalten eine Benachrichtigung, falls mindestens eine verfallene Sendung gefunden wurde."
L["EXPIRY_CHECK_LABEL"] = "Warnung bei verfallender Post" -- Needs review
L["EXPIRY_CHECK_TITLE"] = "Auf verfallende Post überprüfen"
L["SCAN_MAIL_BODY_DISABLED"] = "Nur die Anhänge der Sendungen werden gelesen. Die Sendungen behalten ihren Status \"nicht gelesen\"."
L["SCAN_MAIL_BODY_ENABLED"] = "Der Text jeder Sendung wird gelesen, wenn der Briefkasten gescant wird. Alle Sendungen werden als gelesen markiert."
L["SCAN_MAIL_BODY_LABEL"] = "Brieftext scannen (markiert als gelesen)" -- Needs review
L["SCAN_MAIL_BODY_TITLE"] = "Brieftext scannen"
L["Warn when mail expires in less days than this value"] = "Warnen, wenn Post verfällt in weniger Tagen als "

