import styled from "styled-components"

export const Container = styled.div`
  margin: 0 auto;
  max-width: 84rem;
  padding: 0 0.8rem;
`

export const ButtonLink = styled.a`
  font-size: 1.25rem;
  display: block;
  text-decoration: none;
  color: ${props => props.theme.accentColor};
  font-weight: 800;
  border: ${props => (props.border ? "1px" : "0")} solid;
  padding: 0.6em 1.8125em;
  border-radius: 1.575rem;
  display: flex;
  align-items: center;
`


export const DocsStructure = styled.div`
  display: flex;
  padding-top: 4rem;
`

export const DocSidebarCotainer = styled.div`
  min-width: 20em;
  border: solid 0 #a6a6a6;
  border-right-width: 1px;
  padding: 1em 2em 0 0;
  margin: 0 2em 0 0;
`

export const DocSidebarLink = styled(ButtonLink)`
  padding: 0;
  font-weight: 100;
`

export const Ghlogo = styled.img`
  width: 1em;
  margin-right: 0.6em;
`

