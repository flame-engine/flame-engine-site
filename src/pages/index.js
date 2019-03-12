import React from "react"
import { PageWrapper } from "../components/Page"
import styled from "styled-components"

const Hero = styled.div`
  height: 100vh;
`

const IndexPage = () => {
  return (
    <PageWrapper title="Flame">
      <Hero />
    </PageWrapper>
  )
}

export default IndexPage
