const fs = require('fs');
const flatmap = require('flatmap');
Array.prototype.flatMap = function (mapper) { return flatmap(this, mapper) }

const marked = require('marked');
const xpath = require('xpath');
const xmldom = require('xmldom');

const max = (a, b) => a > b ? a : b;
const readMd = name => fs.readFileSync(`../flame/doc/${name}`, 'UTF-8');
const writeMd = (name, content) => fs.writeFileSync(`build/docs/${name}`, content, 'UTF-8');

const toDoc = markdown => new xmldom.DOMParser().parseFromString(marked(markdown));
const select = (xml, path) => xpath.select(path, toDoc(xml));

const parseList = list => list
  .filter(item => item.childNodes && item.childNodes.length > 0)
  .map(item => ({ parent: item.childNodes[0], children: item.childNodes[1] }))
  .map(({ parent, children }) => ({
    ...(parent.localName === 'a' ? ({ title: parent.firstChild.data, link: parent.getAttribute('href') }) : ({ title: parent.data })),
    ...(children ? { children: parseList(Array.from(children.childNodes)) } : {}),
  }));

const readme = readMd('README.md');
const data = parseList(select(readme, '//h2[@id="topics"]//following::ul/li'));

const allCateogries = {};
const categoryOf = item => allCateogries[item.title] || (allCateogries[item.title] = Object.values(allCateogries).reduce(max, 0) + 1);
const findParent = item => data.find(e => (e.children || []).some(f => f.title === item.title));

const extractInfo = data => {
  const parent = findParent(data);

  const path = `"/docs/${data.link}"`;
  const title = `"${data.title}"`;
  const category = categoryOf(parent);
  const order = parent.children.findIndex(item => item.title === data.title) + 1;

  return { path, title, category, order };
};

const toMd = info => `---\n${Object.entries(info).map(([key, data]) => `${key}: ${data}`).join('\n')}\n---\n`;
const externalLink = url => url.match(/^[a-zA-Z]*:\/\//);
const replaceLinks = md => md.replace(/\[([^\[\]]*)\]\(([^\(\)]*)\)/g, (_, g1, g2) => externalLink(g2) ? `[${g1}](${g2})` : `[${g1}](/docs/${g2.replace(/^doc\//, '')})`);
const enhanceMd = (info, file) => `${toMd(info)}\n${replaceLinks(file)}`;

const links = data.flatMap(e => [e, ...(e.children || [])]).filter(e => e.link);
const writeAll = () => {
  writeMd('getting-started.md', enhanceMd({ path: '"/docs/"', title: '"Getting Started"', category: 0, order: 1 }, readme));
  links.forEach(data => writeMd(data.link, enhanceMd(extractInfo(data), readMd(data.link))));
};

writeAll();

