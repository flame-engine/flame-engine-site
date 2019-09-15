import React from "react"
import styled from "styled-components"
import { Link } from "gatsby"
import { Container, Ghlogo } from "./UI"

import logo from "../images/flame-icon.png"
import ghlogo from "../images/ghlogo.png"

import { AnimatedLogo } from "./AnimatedLogo"
import { ButtonLink } from "./UI"

const HeaderStyled = styled.header`
  position: ${props => (props.isHome ? "absolute" : "relative")};
  top: 0;
  left: 0;
  right: 0;
  font-size: 1.2rem;
`

const Nav = styled.nav`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 2em 0;
`
const LogoLink = styled(Link)`
  display: flex;
  align-items: center;
  transition: all 0.1s;
  opacity: ${props => (props.showLogo ? "1.0" : "0.0")};
`

const NavLinks = styled.div`
  display: flex;
`

const NavLink = styled(ButtonLink)`
  text-size: 0.825rem;
  padding: 0.5rem 1.5rem;
  font-size: 0.8em;
  text-decoration: none;
  font-weight: 800;
  color: ${props => props.theme.accentColor};
`

const LogoImageContainer = styled.div`
  width: 2.5rem;
`

const Logo = ({ showLogo }) => (
  <LogoLink showLogo={showLogo} to="/">
    <LogoImageContainer>
      <img src={logo} alt="Logo" />
    </LogoImageContainer>
    <AnimatedLogo small />
  </LogoLink>
)

export const Header = ({ isHome }) => {
  return (
    <HeaderStyled isHome={isHome}>
      <Container>
        <Nav isHome={isHome}>
          <Logo showLogo={!isHome} />
          <NavLinks>
            <NavLink as={Link} to="/docs">
              Docs
            </NavLink>
            <NavLink
              as="a"
              href="https://pub.dartlang.org/documentation/flame/latest/"
            >
              API
            </NavLink>
            <NavLink border href="https://github.com/luanpotter/flame/">
              <Ghlogo src={ghlogo} alt="github" /> Github
            </NavLink>
          </NavLinks>
        </Nav>
      </Container>
    </HeaderStyled>
  )
}
