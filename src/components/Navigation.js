import React from "react"
import styled from "styled-components"
import { Link } from "gatsby"

const NavLink = styled(Link)`
  text-size: 20px;
`

export const Navigation = () => {
  return (
    <nav>
      <NavLink to="/"> test </NavLink>
    </nav>
  )
}
