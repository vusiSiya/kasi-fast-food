
import {
	authCreateAccountWithEmail,
	signInWithEmail,
	authSignInWithGoogle
} from "../../api"
import google-logo from "../../Images/google-logo.png"


css 
	button 
		fw: bold p: 1em 1.5em bd: none rd: .5rem c: inherit
		bgc: #354645 @hover:orange

	form 
		d: grid bgc: black g: 1em min-width: 15em m: .5em auto p: 1em c: white 
		bd: none rd: .5rem fs:1.5rem @!700:medium

	form > input 
		bd: 4px solid transparent @hover:4px solid blue3 rd: .25rem
		w: auto p: .5em ta: start 
			

tag login

	prop isSignedIn = null

	def getFormData e
		e.preventDefault!
		new FormData(e.target.parentElement)

	def handleSignInWithEmail e
		const formData = 	getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		isSignedIn = await signInWithEmail(email, password)
		e.target.parentElement.reset!
		imba.commit!

	def handleSignInWithGoogle e
		isSignedIn = await authSignInWithGoogle!
		imba.commit!

	def handleSignUp e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		await authCreateAccountWithEmail(email, password)
		e.target.parentElement.reset!


	<self [m:auto]>
		unless isSignedIn === null
			<p [m:auto c:red2 w:100%]> isSignedIn ? "Successully Signed In" : "Invalid Credentials!"

		<form>
			<h4 [ta:center]> "Login or Sign Up"
			<input type="text" name="email" placeholder="email" required />
			<input type="password" name="password" placeholder="password" required />
			<button
				type="submit"
				@click=handleSignInWithEmail
			> "Log in"

			<button type="submit" @click=handleSignUp> "Create Account"
			<button type="submit" @click=handleSignInWithGoogle [d:flex ai:center jc:center]>
				<img [w:2rem] src=google-logo /> " Sign in with Google"
				



