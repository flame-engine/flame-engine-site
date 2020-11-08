// A docsify plugion to add a header on the top of each documentation page

const Header = `
    <header>
        <div>
            <a href="https://flame-engine.org">Home</a>
            <a href="https://flame-engine.org/api">API</a>
            <a href="https://github.com/flame-engine/flame">Github</a>
            <a href="https://discord.com/invite/pxrBmy4">Discord</a>
        </div>
    </header>
`

export const HeaderPlugin = (hook) => {
    hook.afterEach(content => {
        return Header + content;
    })
}
