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

	prop isSignedIn

	def getFormData e
		e.preventDefault!
		new FormData(e.target.parentElement)

	def handleSignInWithEmail e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		isSignedIn = await signInWithEmail(email, password)
		emit("signed-in", isSignedIn)
		imba.commit!
	
	def handleSignInWithGoogle e
		e.preventDefault!
		isSignedIn = await authSignInWithGoogle!
		imba.commit!

	def handleSignUp e
		const formData = getFormData(e)
		const email = formData.get("email")
		const password = formData.get("password")
		await authCreateAccountWithEmail(email, password)


	<self [m:auto]>
		if (isSignedIn === false) then <span> "Oops invalid credentials"
		<form>
			<h4 [ta:center]> "Login or Sign Up"
			<input type="text" name="email" placeholder="email" required/>
			<input type="password" name="password" placeholder="password" required />
			<button
				type="submit"
				@click=handleSignInWithEmail
			> "Log in"
			<button type="submit" @click=handleSignUp> "Create Account"
			<button type="submit" @click=handleSignInWithGoogle [d:flex ai:center jc:center]>
				<img [w:2rem] src="https://logos-world.net/wp-content/uploads/2020/09/Google-Symbol-700x394.png" />
				" Sign in with Google"
				



