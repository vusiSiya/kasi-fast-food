import { initializeApp } from "firebase/app";

// firestore
import {
	getFirestore,
	collection,
	getDocs,
	getDoc,
	doc,
	deleteDoc, 
	addDoc,
	setDoc,
	updateDoc, 
	query,
	where
} from "firebase/firestore";

// authentication
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
import { nanoid } from 'nanoid'


const firebaseConfig = {
  apiKey: "AIzaSyBsFammEWm4YtfZfZ-Xy2Gy1f1AE4fp720",
  authDomain: "imba-menu-app.firebaseapp.com",
  projectId: "imba-menu-app",
  storageBucket: "imba-menu-app.appspot.com",
  messagingSenderId: "911793695166",
  appId: "1:911793695166:web:fdbe46a00ce94a2a6931ef"
};

//initialisation
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app)
const provider = new GoogleAuthProvider()

const itemsCollectionRef = collection(db,"items");
const cartItemsCollectionRef = collection(db, "items-on-cart")

// functions, --reading data--
export const getAllItems = async ()=>{
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {...doc.data(), id: doc.id + nanoid(10)}
	});
	return dataArray;
}

export const getSingleItem = async (id="")=>{
	const generalItemsRef = doc(db, "items", id[0].toString());
	const itemSnapShot = await getDoc(generalItemsRef);
	return {
		...itemSnapShot.data(),
		id: id
	}
}

export const getSingleCartItem = async (id)=>{
		const cartItems = await get(getCartItems);
		return cartItems ? cartItems.find(item=> item.id[0] === id[0]) : null
}

export const getCartItems = async()=>{
	const userId = auth.currentUser?.uid
	const q = query(cartItemsCollectionRef, where("uid", "==", userId))
	const querySnapshot = await getDocs(q);
	const cartItems = querySnapshot?.docs.map(doc =>{
		return {
			...doc.data()
		}
	})
	return cartItems
}

export const getTotalCount = async()=>{
	const cartItems = await get(getCartItems);
	const count = cartItems?.reduce((sum,item)=>(sum + item.count), 0);
	return count || 0
}

export const getTotalPrice = async()=>{
	const cartItems = await get(getCartItems);
	const totalPrice = cartItems?.reduce((sum,item)=>(sum + item.price * item.count), 0);
	return totalPrice || 0
}


// functions, --writing--
export const addItemToCart = async (id="")=>{
	try {
		const item = await getSingleItem(id);
		const user_uid = auth.currentUser?.uid || localStorage.getItem("user-uid");
		await setDoc(doc(db, "items-on-cart", id),{
			...item,
			count: 1,
			uid: user_uid
		})
		
	} catch (err) {
		console.error(err.message)
	}
}

export const updateItemCount= async (id, count)=>{
	try {
		const itemRef = doc(db, "items-on-cart", id.toString())
		await updateDoc(itemRef, {
			count: Number(count)
		})
	} catch (err) {
		console.error(err.message)
	}
}

export const removeItem = async (id)=>{
	try {
		const itemRef = doc(db, "items-on-cart", id.toString())
		await deleteDoc(itemRef)
	} catch (err) {
		console.error(err.message)
	}
}


export const get = async (func)=>{  // my refactor of 'tryCatch'
	try {
		const data = await func()
		return data
	} catch (err) {
		console.error(err.message)
		return null
	}
}

// auth
onAuthStateChanged(auth, (user) => {
	if (user) {
	  const uid = user.uid;
	  localStorage.setItem("user-uid", uid)
	} 
	else 
		localStorage.removeItem("user-uid")

})

export const checkAuthState = ()=>{
	const user_uid = localStorage.getItem("user-uid")
	return user_uid ? true : false
}

export const authCreateAccountWithEmail = async (email, password)=>{
		const userCredential = await createUserWithEmailAndPassword(auth, email, password)
		const user = userCredential.user;
		alert("account successfully created!");
}

export const anonymousSignIn = async()=>{
	await signInAnonymously(auth)
}

export const signInWithEmail = async (email, password)=>{
	// do I need to recive an isloggedIn boolean parameter? to return ?
		await signInWithEmailAndPassword(auth, email, password)
}


export const authSignInWithGoogle= async()=> {
      await signInWithPopup(auth, provider)
}

export const authSignOut= async()=>{
	await signOut(auth)
}


