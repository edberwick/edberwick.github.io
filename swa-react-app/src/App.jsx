import React from 'react'
import AzureFeed from './AzureFeed'

export default function App(){
  return (
    <div className="app">
      <header className="app-header">
        <h1>Azure Updates Aggregator</h1>
        <p>Combined feed of Microsoft Azure updates and blogs.</p>
      </header>
      <main>
        <AzureFeed />
      </main>
    </div>
  )
}
