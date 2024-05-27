
import {
	authCreateAccountWithEmail,
	signInWithEmail,
	authSignInWithGoogle,
	anonymousSignIn,
	checkAuthState
} from "../../api"
import google-logo from "../../Images/google-logo.png"


css 
	button 
		fw: bold p: 1em 1.5em bd: none rd: .5rem c: inherit
		bgc: #354645 @hover:orange

	form 
		d: grid bgc:black g:.8em min-width:15em m:.5em auto p:1em c: white 
		bd: none rd: .5rem fs:1.5rem @!700:medium 

	form > input 
		bd: 4px solid transparent @hover:4px solid blue3 rd: .25rem
		w: auto p:.5em ta: start 
			

tag login
	prop signedIn = checkAuthState! or null

	def getFormData e
		new FormData(e.target)

	def handleEmailSignIn e
		const formData = 	getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		e.target.reset!
		await signInWithEmail(email, password)
		signedIn = checkAuthState!

	def handleAnonymousAuth
		await anonymousSignIn!
		signedIn = checkAuthState!

	def handleGoogleSignIn e
		await authSignInWithGoogle!
		signedIn = checkAuthState!

	def handleSignUp e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		await authCreateAccountWithEmail(email, password)
		e.target.reset!
	
	def handleSubmit e
		if e.submitter.id === "sign-in"
			await handleEmailSignIn(e)
		else await handleSignUp(e) 

	<self [m:auto c:white]>
		<form @submit.prevent()=handleSubmit>
			<h4 [ta:center]> "Sign in or Sign up"
			unless signedIn === null
				<p [m:0 c:orange fs:small fw:bold]> signedIn === true ? "Successully Signed In" : "Invalid Credentials!"
		
			<input type="text" name="email" placeholder="email" required autocomplete="off" />
			<input type="password" name="password" placeholder="password" required autocomplete="off" />
			<button type="submit" id="sign-in"> "Sign In"
			<button type="submit" id="sign-up"> "Sign Up"
			<section [d:grid g:.4em]>
				<button type="button" @mousedown=handleAnonymousAuth> "Sign In Anonymously"
				<button [d:flex ai:center jc:center] type="button" @mousedown=handleGoogleSignIn>
					<img [w:2rem] src=google-logo /> "Sign In with Google"



