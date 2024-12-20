
import { signOut } from "firebase/auth" 
import { auth, checkAuthState } from "../../auth"
import { getTotalCount, redirect } from "../../api"


css section d:flex g:1rem ai:flex-end m:.5em jc:space-between w:100%
css a bgc:white c:black p:.4em rd:.28em td:none ta:center 
css section > div > a@hover bgc:black3 c:white

css .login bgc:orange c:white ta:center p:.55em .15em
css .login, img.profile bd:1px solid white rd:100% w:2rem bxs@hover: 0 0 8px 2px grey
	
css div.select d:none fw:bold pos:absolute top:1rem right:5rem max-width:fit-content
	fs:small rd:.2rem p:.5rem bgc:white c:black
css div.select > p cursor:pointer m:.5rem d:flex g:.5em ai:baseline
	@hover td:underline color:orange

css .menu-bar fs:x-large bgc:inherit c:white bd:none 
	@hover bd: 1px solid silver rd:.25rem
css .small-cart p:.2em fs:x-small rd:100% bd:1px solid red
css .grid d:grid ji:center
	

tag nav-bar
	prop showMenu = false
	prop showOptions = false
	prop smallScreen = false

	def handleSignOut e
		const {textContent} = e.target
		if checkAuthState! and textContent === "Logout"
			auth.currentUser.isAnonymous && await auth.currentUser.delete!
			await signOut(auth)
			redirect("/")
	
	def render
		const isSignedIn = checkAuthState!
		const user = auth.currentUser
		const protectedRoute = isSignedIn ? "/items-on-cart" : "/not-signed-in"
		const {orientation} = window.screen
		smallScreen = orientation.type === "portrait-primary"

		<self>
			<section>
				<div [align-self:flex-start]>
					<h1 [w:fit-content fs:2rem @!760:1.5rem m:0 ml:2rem @!760:auto]> "Fast Food"

				if smallScreen
					<div [pos: relative]>
						<button.menu-bar @mousedown=(showMenu = !showMenu)>
							<i.fa-solid .fa-bars>
						<div.select [d:grid fs:medium fw:normal p:0 min-width:7rem]=showMenu .grid=showMenu>
							<p> <a route-to="/items"> "Menu"
								<i .fa-solid .fa-burger>
							<p [gap:2px]> <a route-to=protectedRoute> "Cart"
								<i.fa-solid .fa-truck-fast [fs:small]>
								<span.count .small-cart> (await getTotalCount! || 0)	
							<p> 
								<a route-to=(isSignedIn ? "/" : "/login")
									@mousedown=handleSignOut> isSignedIn ? "Logout" : "Login"
								<i .fa-regular .fa-user .login[max-width:1.3rem fs:x-small]>
				else
					<div[d:flex ai:flex-end g:2rem]>
						<section [jc:end pr:1rem m:0]>
							<a [fw:bold] route-to="/items"> "Menu"
							<a [d:flex ai:center fs:small g:.5rem] route-to=protectedRoute> 
								<i.fa-solid .fa-truck-fast>
								<span.count> (await getTotalCount! || 0)
								
							if user
								<div [d:flex pos:relative] @mousedown=(showOptions = !showOptions)> 
									<div [order:-1 d:flex gap:.5em ai:center fs:small]>
										<p> (user.displayName or user.email or "Anonymous User")
										
										if user.isAnonymous
											<span.login> <i.fa-regular .fa-user>
										else 
											<img.profile src=(user.photoURL) alt="profile-img">
									<div.select [d:grid ji:center]=showOptions>
										<p> "Profile"  
										<p @mousedown=handleSignOut> "Logout"
							else 
								<a .login route-to="login">
									<i .fa-regular .fa-user>

