
import { authSignOut } from "../../auth"
import { getTotalCount, checkAuthState } from "../../api"


css section d:flex g:1rem ai:flex-end m:.5em
css a bgc:white c:black p:.4em rd:.28em td:none ta:center 
css section > div > a@hover bgc:black3 c:white

css .login bgc:orange c:white ta:center p:.8rem .2rem
css .login, img.profile bd:1px solid silver rd:100% w:2.5rem
	@hover border-color:white box-shadow: 0 0 8px 2px grey

css div.select d:none pos:absolute top:1rem right:5rem w:5rem
	fs:small rd:.2rem p:.5rem bgc:aliceblue c:black
css div.select > p cursor:pointer fw:bold m:.5rem
	@hover td:underline color:orange


tag nav-bar
	prop currentUser
	prop show-options = false

	def render
		let user = checkAuthState! && currentUser
		<self>
			<section>
				<h2 [m:0 ml:2rem @!760:auto]> "Fast Food"
				<div [d:flex ai:flex-end g:1em]>
					<a [d:flex ai:center fs:small g:.5rem]
						route-to=(checkAuthState! ? "items-on-cart" : "/not-signed-in")> 
						<i.fa-solid .fa-truck-fast>
						<span.count> (await getTotalCount! || 0)
					<a [fw:bold] route-to="items"> "Menu"

			<section [jc:end pr:3rem]>
				if user
					<div [d:flex pos:relative] @mousedown=(show-options = !show-options)> 
						<div [order:-1 d:flex gap:.5em ai:center fs:small]>
							<p> (user.displayName or user.email or "Anonymous User")

							if user.isAnonymous then <span.login> <i .fa-regular .fa-user>
							else <img .profile src=(user.photoURL) alt="profile-img">

						<div.select [d:grid ji:center]=show-options>
							<p> "Profile"  
							<p @mousedown=(authSignOut!)> "Logout"
				else 
					<a.login route-to="login" >
						<i .fa-regular .fa-user>
