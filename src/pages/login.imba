
import {
	createUserWithEmailAndPassword,
	signInWithEmailAndPassword,
	signInWithPopup,
	signInAnonymously
} from "firebase/auth"
import {auth, provider, checkAuthState } from "../../auth"
import googleLogo from "../../Images/google-logo.png"
import {redirect}  from "../../api"


css button fw:bold p:1em 1.5em bd:none rd:.5rem c:inherit 
	bgc:#354645 @hover:orange

css form d:grid bgc:black g:.8em min-width:15em m:.5em auto p:1em c:white 
	bd:none rd:.5rem fs:1.5rem @!700:medium 

css form > input bd:4px solid transparent bc@hover:blue3 rd:.25rem
	w:auto p:.5em ta:start 
			

tag login
	prop errorMsg = ""
	
	def handleSubmit e
		const {id} = e.submitter || e.target  # getting the button's id
		try
			if id === "google-auth" then await signInWithPopup(auth, provider)
			else if id === "anonymous-auth" then await signInAnonymously(auth)

			if e.submitter
				const formData = new FormData(e.target)
				const email = formData.get("email").toString!
				const password = formData.get("password").toString!

				if id === "sign-in" then await signInWithEmailAndPassword(auth, email, password)

				else if id === "sign-up"
					const cred = await createUserWithEmailAndPassword auth, email, password
					if !cred.user.emailVerified
						await cred.user.delete!
						throw new Error("😤 Invalid Email!")
		catch error
			errorMsg = error.message
			setTimeout(&, 80) do window.location.reload!

		if e.submitter then e.target.reset!
		if !errorMsg then setTimeout(&, 80) do
			redirect("/items-on-cart")
		
	def render
		const signedIn = checkAuthState!
		const feedback = (signedIn and !errorMsg) ? "Successully Signed In" : errorMsg
		
		<self [m:auto c:white]>
			<form @submit.prevent()=handleSubmit>
				<h4 [ta:center]> "Sign in or Sign up"
				<p [m:0 c:orange fs:small fw:bold] [c:orangered]=errorMsg> feedback
				<input [bc:orangered]=errorMsg type="email" name="email" placeholder="email" required autocomplete="off" />
				<input [bc:orangered]=errorMsg type="password" name="password" placeholder="password" required autocomplete="off" />
				<button type="submit" id="sign-in" [bgc:orange]> "Sign In"
				<button type="submit" id="sign-up"> "Sign Up"
				<section [d:grid g:.4em]>
					<p [fs:small m:0 ta:center]> "or"
					<button type="button" id="anonymous-auth" @mousedown=handleSubmit> "Sign In Anonymously"
					<button [d:flex ai:center jc:center] type="button" id="google-auth" @mousedown=handleSubmit>
						<img [w:2rem] src=googleLogo /> "Sign In with Google"

