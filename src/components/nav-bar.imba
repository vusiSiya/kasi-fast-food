
import { authSignOut } from "../../auth"
import { getTotalCount, checkAuthState } from "../../api"


css section d:flex g:1rem ai:flex-end m:.5em jc:space-around w:100%
css a bgc:white c:black p:.4em rd:.28em td:none ta:center 
css section > div > a@hover bgc:black3 c:white

css .login bgc:orange c:white ta:center p:.55rem .15rem
css .login, img.profile bd:1px solid white rd:100% w:2rem
	@hover box-shadow: 0 0 8px 2px grey

css div.select d:none pos:absolute top:1rem right:5rem w:5rem
	fs:small rd:.2rem p:.5rem bgc:aliceblue c:black
css div.select > p cursor:pointer fw:bold m:.5rem
	@hover td:underline color:orange


tag nav-bar
	prop currentUser
	prop showMenu = false
	prop showOptions = false
	prop smallScreen = false
	prop media-query-list = window.matchMedia("max-width: 759px")

	def handleChange e
		if e.matches then smallScreen = true 
		else smallScreen = false

	def render
		let user = checkAuthState! && currentUser
		console.log(media-query-list)
		<self @change=(media-query-list, handleChange)>
			<section>
				<div[flex:1 1 max-content]>
					<h1 [w:fit-content fs:2rem bdb:dotted m:0 ml:2rem @!760:auto]> "Fast Food"
					
				if smallScreen
					<div [pos: relative]>
						<button @mousedown=(showMenu = !showMenu)> <i .fa-solid .fa-bars>
						<div.select [d:grid ji:center ]=showMenu>
							<p><a route-to=( checkAuthState! ? "items-on-cart" : "/not-signed-in" )> 
								<i.fa-solid .fa-truck-fase>
							<p> 
								<a route-to="/items"> <i .fa-solid .fa-burger>
							<p>
								<a .login route-to="login"> <i .fa-regular .fa-user>
				else
					<div[d:flex ai:flex-end g:2rem]>
						<a [fw:bold] route-to="/items"> "Menu"
						<a [d:flex ai:center fs:small g:.5rem]
							route-to=( checkAuthState! ? "items-on-cart" : "/not-signed-in")
						> 
							<i.fa-solid .fa-truck-fast>
							<span.count> (await getTotalCount! || 0)
						<section [jc:end pr:1rem m:0]>
							if user
								<div [d:flex pos:relative] @mousedown=(showOptions = !showOptions)> 
									<div [order:-1 d:flex gap:.5em ai:center fs:small]>
										<p> (user.displayName or user.email or "Anonymous User")

										if user.isAnonymous then <span.login><i .fa-regular .fa-user>
										else <img.profile src=(user.photoURL) alt="profile-img">

									<div.select [d:grid ji:center]=showOptions>
										<p> "Profile"  
										<p @mousedown=(authSignOut!)> "Logout"
							else 
								<a .login route-to="login">
									<i .fa-regular .fa-user>




