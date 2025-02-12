import '@/styles/globals.css'
import { Web3Modal } from '@/context/web3modal';
export const metadata = {
  title: 'NexaFi ',
  description: 'The most efficient protocol on Rootstock featuring a DAO, lending/borrowing dApp, swap dApp, Staking dApp, token, treasury'
}

export default function App({ Component, pageProps }) {
  return  <Web3Modal> <Component {...pageProps} /> </Web3Modal>
}
