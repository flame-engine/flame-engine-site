import React from "react"
import styled from "styled-components"

import { Container } from "./Container"
import { Navigation } from "./Navigation"

const HeaderStyled = styled.header`
  background-color: #fff;
`

export const Header = () => {
  return (
    <HeaderStyled>
      <Container>
        <Navigation />
      </Container>
    </HeaderStyled>
  )
}
