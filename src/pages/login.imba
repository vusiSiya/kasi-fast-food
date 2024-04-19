import {
	authCreateAccountWithEmail,
	signInWithEmail,
	authSignInWithGoogle
} from "../../api"

tag login
	css 
		form 
			d: grid bgc: black g: 1em min-width: 15em m: .5em auto p: 1em c: white 
			bd: none rd: .5rem fs:1.5rem @!700:medium

		form > input 
			bd: 4px solid transparent @hover:4px solid blue3 rd: .25rem
			w: auto p: .5em ta: start 
				
		button 
			fw: bold p: 1em 1.5em bd: none rd: .5rem c: inherit
			bgc: #354645 @hover:orange


	prop isVerifiedUser = true

	def getFormData
		const form-tag = document.querySelector "form"
		new FormData(form-tag)

	def handleSignInWithEmail
		const formData = getFormData!
		const email = formData.get("email")
		const password = formData.get("password")
		const isSignedIn = await signInWithEmail(email, password)
		isVerifiedUser = isSignedIn
	
	def handleSignInWithGoogle
		const isSignedIn = await authSignInWithGoogle!
		imba.commit!
		isVerifiedUser = isSignedIn

	def handleSignUp
		const formData = getFormData!
		const email = formData.get("email")
		const password = formData.get("password")
		authCreateAccountWithEmail(email, password)


	<self [m:auto]>
		# (isVerifiedUser === false) && <p> "It looks like you don't have an account. Sign Up instead!"
		<form @submit>
			<h4 [ta:center]> "Login or Sign Up"
			<input type="text" name="email" placeholder="email" required/>
			<input type="password" name="password" placeholder="password" required />
			<button
				type="submit"
				@click=handleSignInWithEmail
			> <a route-to=(isVerifiedUser ? "/items-on-cart" : "/login")> "Log in"
			# <div [d:grid w:100% g: .25rem gtc: 1fr 1fr]>
			<button type="submit" @click=handleSignUp> "Create Account"
			<button type="submit" @click=handleSignInWithGoogle [d:flex ai:center jc:center]>
				<img [w:2rem] src="https://logos-world.net/wp-content/uploads/2020/09/Google-Symbol-700x394.png" />
				" Sign in with Google"
				



