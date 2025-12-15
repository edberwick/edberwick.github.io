const Parser = require('rss-parser')
const parser = new Parser()

module.exports = async function (context, req) {
  context.log('aggregate function invoked')
  const feeds = [
    'https://azure.microsoft.com/en-us/blog/feed/',
    'https://azure.microsoft.com/en-us/updates/feed/'
  ]

  try {
    const parsed = await Promise.all(feeds.map(url => parser.parseURL(url)))
    let items = []
    parsed.forEach(feed => {
      const source = feed.title || ''
      (feed.items || []).forEach(it => items.push(Object.assign({}, it, { source })))
    })
    items.sort((a,b)=> new Date(b.isoDate || b.pubDate) - new Date(a.isoDate || a.pubDate))
    context.res = {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
      body: items.slice(0, 100)
    }
  } catch (err) {
    context.log.error(err)
    context.res = { status: 500, body: { error: err.message } }
  }
}
