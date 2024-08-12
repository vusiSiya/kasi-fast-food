import { initializeApp } from "firebase/app";
import {getFirestore} from "firebase/firestore";
import {
	getAuth,
	createUserWithEmailAndPassword,
	signInWithPopup,
	GoogleAuthProvider,
	signInWithEmailAndPassword,
	signInAnonymously,
	onAuthStateChanged, 
	signOut
} from "firebase/auth";


const firebaseConfig = {
   apiKey: "AIzaSyBsFammEWm4YtfZfZ-Xy2Gy1f1AE4fp720",
   authDomain: "imba-menu-app.firebaseapp.com",
   projectId: "imba-menu-app",
   storageBucket: "imba-menu-app.appspot.com",
   messagingSenderId: "911793695166",
   appId: "1:911793695166:web:fdbe46a00ce94a2a6931ef"
 };


// initialisation
 export const app = initializeApp(firebaseConfig);
 export const auth = getAuth(app)
 const provider = new GoogleAuthProvider()

// auth
onAuthStateChanged(auth, (user) => {
	if (user) {
	  localStorage.setItem("user-uid", user.uid)
	  return
	} 
	localStorage.removeItem("user-uid")
})

export function checkAuthState(){
	const user_uid = localStorage.getItem("user-uid")
	return user_uid ? true : false
}

export async function authCreateAccountWithEmail (email: string, password: string){
	const userCredential = await createUserWithEmailAndPassword(auth, email, password)
	const user = userCredential.user;
	alert("account successfully created!");
}

export async function anonymousSignIn(){
	await signInAnonymously(auth)
}

export async function signInWithEmail(email: string, password: string){
	await signInWithEmailAndPassword(auth, email, password)
}

export async function authSignInWithGoogle(){
      await signInWithPopup(auth, provider)
}

export async function authSignOut(){
	await signOut(auth)
}