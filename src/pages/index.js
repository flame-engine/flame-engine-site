import React from "react"

import styled from "styled-components"
import GitHubButton from "react-github-button"

import { PageWrapper } from "../components/Page"
import { ButtonLink } from "../components/Button"
import { AnimatedLogo } from "../components/AnimatedLogo"

import logo from "../images/flame-icon.png"
import ghlogo from "../images/ghlogo.png"
import { Ghlogo } from "../components/UI";

const HeroContainer = styled.div`
  height: 100vh;
  min-height: 45.25em;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding-top: 5em;
`

const HeroImageContainer = styled.div`
  width: 12.5em;
`

const HeroImage = () => (
  <HeroImageContainer>
    <img src={logo} alt="Logo" />
  </HeroImageContainer>
)

const Flex = styled.div`
  display: flex;
  align-self: stretch;
  justify-content: center;
  flex-wrap: wrap;
  & > *:first-child {
    margin-right: 2.25em;
  }
  @media (max-width: 40em) {
    font-size: 1.8em;
    & > *:first-child {
      margin-right: 0;
    }
  }
`

const HeroText = styled.p`
  font-size: 1.875rem;
  color: #333;
  font-weight: 200;
  margin: 2em 0;
  text-aligin: center;
  @media (max-width: 40em) {
    font-size: 1.4rem;
  }
  & b {
    font-weight: 800;
  }
`

const IndexPage = () => {
  return (
    <PageWrapper title="Flame">
      <HeroContainer>
        <HeroImage />
        <AnimatedLogo />
        <GitHubButton
          type="stargazers"
          size="large"
          namespace="luanpotter"
          repo="flame"
        >
          Star
        </GitHubButton>
        <HeroText>
          2D game engine made on top of <b>Flutter</b>
        </HeroText>
        <Flex>
          <ButtonLink href="https://github.com/luanpotter/flame/" border>
            <Ghlogo src={ghlogo} alt="github" /> Github
          </ButtonLink>
          <ButtonLink href="/docs">Get started</ButtonLink>
          <ButtonLink href="https://pub.dartlang.org/documentation/flame/latest/">
            API reference
          </ButtonLink>
        </Flex>
      </HeroContainer>
    </PageWrapper>
  )
}

export default IndexPage
