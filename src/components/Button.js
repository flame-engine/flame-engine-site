import styled from "styled-components"

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
