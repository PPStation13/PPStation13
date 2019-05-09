/mob/key_down(_key, client/user)
	if(client.keys_held["Ctrl"])
		switch(_key)
			if("P")
				emote("pee")
				return
			if("O")
				emote("poo")
				return
	return ..()