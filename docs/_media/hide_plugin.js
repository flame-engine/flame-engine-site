// A docsify plugion to add a header on the top of each documentation page

const ignoreRegex = new RegExp("<!-- {ignore} -->([\\s\\S]*)<!-- {\\/ignore} -->")

export const HidePlugin = (hook) => {
    hook.afterEach(content => {
        return content.replace(ignoreRegex, "");
    })
}
