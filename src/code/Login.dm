mob/Logout()
	for(var/mob/M in Players)
		if(M.Admin)
			M << "<font color = teal>([usr.key])[usr] logs out.<br>"

		usr.RemoveOwnedItems()
		range(6, usr) << "<font color = teal>([usr.key])[usr] logs out.<br>"
		usr.Save()
		del(usr)


mob/Login()
	if(usr.client.address in BanList || usr.key in BanList)
		usr << "You are banned..."
		del(usr)
		return

	var/image/I = new('Target.dmi', usr)
	usr.TargetIcon = I

	loadadmins()

	usr.loc = locate(11, 11, 2)
	usr.density = 0
	usr.CanMove = 0
	usr.luminosity = 0
	usr.client.mouse_pointer_icon = 'Cursor.dmi'

	usr << sound('Intro.mid', 1)

	for(var/mob/M in Players)
		if(M.Admin)
			M << "<font color = teal>[usr] logs in.<br>"

	usr << "<font color = blue><b>.:Rules:. - This is a RP game, you must never use Out of Character (OOC) information in a In Character (IC) Role Play (RP), failure to follow this -VERY- simple rule will most likely end up in a Punish.<p>"
	usr << "Macros - S = Say, O = OOC, R = RolePlay<p>"
	usr << "<font color =teal>It is Year [Year], Month [Month]<p>"

	if(usr.client.IsByondMember())
		if(!(usr.key in LizardmanList))
			LizardmanList += usr.key
			usr << "<font color = teal><font size = 4><b>Thank you for being a member and supporting Byond. You may now play as a lizardman.<br>"

	Players += usr