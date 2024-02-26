
tag login
	css 
		form 
			d: grid g: 1em bgc: black min-width: 15em m: .5em auto p: 1em c: white 
			bd: none rd: .5rem fs:1.5rem @!700:medium

		form > input 
			bd: 5px solid transparent @hover:5px solid blue3 rd: .25rem
			w: auto p: .5em bw: 5px ta: start 
				
		form > button 
			fw: bold p: 1em 1.5em bd: none rd: .5rem c: inherit
			bgc: #344544 @hover:orange 
			
	<self.container [margin:auto]>
		<form>
			<h4 [ta:center] > "Login or Sign Up"
			<input type="text" name="username" placeholder="name" required/>
			<input type="password" name="password" placeholder="password" required />
			<label [fs: 1rem] htmlFor="remember-me">
				<input type="checkbox" name="remember-me"  title="Remember me" required />
				<span> "Remember me"
			<button type="submit" > "Login"
			<button type="button"> "Sign Up"