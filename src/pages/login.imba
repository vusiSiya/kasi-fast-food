
import {
	authCreateAccountWithEmail,
	signInWithEmail,
	authSignInWithGoogle,
	anonymousSignIn,
	checkAuthState
} from "../../auth"
import google-logo from "../../Images/google-logo.png"


css button fw:bold p:1em 1.5em bd:none rd:.5rem c:inherit 
	bgc:#354645 @hover:orange

css form d:grid bgc:black g:.8em min-width:15em m:.5em auto p:1em c:white 
	bd:none rd:.5rem fs:1.5rem @!700:medium 

css form > input bd:4px solid transparent @hover:4px solid blue3 rd:.25rem
	w:auto p:.5em ta:start 
			
			
tag login
	prop signedIn = null

	def getFormData e
		new FormData(e.target)

	def handleEmailSignIn e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		e.target.reset!
		await signInWithEmail(email.toString!, password.toString!)
		imba.commit!

	def handleAnonymousAuth
		await anonymousSignIn!
		imba.commit!

	def handleGoogleSignIn e
		await authSignInWithGoogle!
		imba.commit!

	def handleSignUp e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		await authCreateAccountWithEmail(email.toString!, password.toString!)
		e.target.reset!
	
	def handleSubmit e
		if e.submitter.id === "sign-in"
			await handleEmailSignIn(e)
		else await handleSignUp(e) 
			
	def render
		<self [m:auto c:white]>
			<form @submit.prevent()=handleSubmit>
				<h4 [ta:center]> "Sign in or Sign up"

				unless checkAuthState! === null
					<p [m:0 c:orange fs:small fw:bold]>
						checkAuthState! ? "Successully Signed In" : "Invalid Credentials!"
			
				<input type="email" name="email" placeholder="email" required autocomplete="off" />
				<input type="password" name="password" placeholder="password" required autocomplete="off" />
				<button type="submit" id="sign-in"> "Sign In"
				<button type="submit" id="sign-up"> "Sign Up"
				<section [d:grid g:.4em]>
					<p [fs:small m:0 ta:center]> "or"
					<button type="button" @mousedown=handleAnonymousAuth> "Sign In Anonymously"
					<button [d:flex ai:center jc:center] type="button" @mousedown=handleGoogleSignIn>
						<img [w:2rem] src=google-logo /> "Sign In with Google"



