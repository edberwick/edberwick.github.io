import React, {useEffect, useState} from 'react'

function fmtDate(d){
  try{ return new Date(d).toLocaleString() }catch(e){return d}
}

export default function AzureFeed(){
  const [items, setItems] = useState(null)
  const [error, setError] = useState(null)

  useEffect(()=>{
    let mounted = true
    fetch('/api/aggregate')
      .then(r=>{
        if(!r.ok) throw new Error(`HTTP ${r.status}`)
        return r.json()
      })
      .then(data=>{ if(mounted) setItems(data) })
      .catch(err=>{ if(mounted) setError(err.message) })
    return ()=>{ mounted = false }
  },[])

  if(error) return <div className="error">Error: {error}</div>
  if(!items) return <div>Loading feed...</div>

  return (
    <section className="feed">
      {items.map((it, idx)=> (
        <article key={idx} className="feed-item">
          <h3><a href={it.link} target="_blank" rel="noopener noreferrer">{it.title}</a></h3>
          <div className="meta">{it.source} — {fmtDate(it.isoDate||it.pubDate)}</div>
          {it.contentSnippet && <p>{it.contentSnippet}</p>}
        </article>
      ))}
    </section>
  )
}
