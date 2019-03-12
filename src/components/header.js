import React from "react"
import styled from "styled-components"
import { Link } from "gatsby"
import { Image } from "./Image"
import { Container } from "./Container"

const HeaderStyled = styled.header`
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  font-size: 1.2rem;
`

const Nav = styled.nav`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 0;
`
const LogoLink = styled(Link)`
  display: block;
  width: 3rem;
  transition: all 0.1s;
  opacity: ${props => (props.showLogo ? "1.0" : "0.0")};
`

const NavLinks = styled.div`
  display: flex;
  font-weight: 800;
`

const NavLink = styled(Link)`
  text-size: 1.25rem;
  margin: 0 2em;
  display: block;
  text-decoration: none;
  color: ${props => props.theme.accentColor};
  &:last-child {
    margin-right: 0;
  }
`

const Logo = ({ showLogo }) => (
  <LogoLink showLogo={showLogo} to="/">
    <Image maxWidth={50} />
  </LogoLink>
)

export const Header = ({ showLogo }) => {
  return (
    <HeaderStyled>
      <Container>
        <Nav>
          <Logo showLogo={showLogo} />
          <NavLinks>
            <NavLink to="/">Articles</NavLink>
            <NavLink to="/">Games</NavLink>
            <NavLink to="/">Docs</NavLink>
          </NavLinks>
        </Nav>
      </Container>
    </HeaderStyled>
  )
}
