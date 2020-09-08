import React from "react"
import styled from "styled-components"
import { Container } from "./UI"

const FlameconLink = styled.a`
  position: absolute;
  top: 0px;
  left: 0;
  right: 0;
  height: 75px;
  background-image: radial-gradient(rgba(0, 0, 0, 0.01), rgba(0, 0, 0, 0.1)),
    linear-gradient(#eb1930, #f95534);
  color: white;
  font-size: 0.625rem;

  & > div {
    display: flex;
    align-items: center;
    height: 75px;
    padding: 1em 0.8rem;
  }

  & .flamecon-desc {
    display: flex;
    align-items: center;
    flex: 1;
    & h5 {
      line-height: 1;
    }
    & .flamecon-tagline {
      font-size: 2em;
      line-height: 1;
      margin-top: 0;
      margin-left: 10px;

      @media (max-width: 640px) {
        display: none;
      }
    }
  }

  & .flamecon-cta {
    font-weight: 400;
    padding: 0.4125em 0.8em;
    font-size: 1.6em;
  }
`

export const FlameconBanner = () => {
  return (
    <FlameconLink title="See the Flamecon landing page" href="/flamecon">
      <Container>
        <div className="flamecon-desc">
          <h5 className="flamecon-title">FLAMECON</h5>
          <div className="flamecon-tagline">Flutter game engine conference</div>
          <div className="flamecon-tagline">16 Sept - 20:00 UTC</div>
        </div>
        <spam className="flamecon-cta">Check it out</spam>
      </Container>
    </FlameconLink>
  )
}
