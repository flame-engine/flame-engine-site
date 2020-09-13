import React from "react"
import styled, { keyframes } from "styled-components"

const flame1 = keyframes`
	0%{
		transform: translate(0) scale(1);
		opacity: 1;
		backgroubnd-color: #ecc504;
	}
	30% {
		transform: translate(28px, -15px) scale(0.8);
		opacity: 1;
	}
	50% {
		transform: translate(10px, -35px)scale(0.7);
		opacity: 1;
		background-color: #ec6404;
	}
	80% {
		transform: translate(50px, -50px) scale(0.5);
		opacity: 0.1;
		background-color: #e80711;
	}
	100% {
		transform: translate(50px, -50px) scale(0.5);
		opacity: 0;
	}
`

const flame2 = keyframes`
	0%{
		transform: translate(0) scale(1);
		opacity: 1;
	}
	24% {
		transform: translate(-10px, -30px) scale(0.6);
		opacity: 1;
	}
	64% {
		transform: translate(10px, -50px)scale(0.4);
		opacity: 0.5;
	}
	80% {
		transform: translate(0px, -60px) scale(0.2);
		opacity: 0;
		background-color: #e80711;
	}
	100% {
		opacity: 0;
	}
`

const flame3 = keyframes`
	0%{
		transform: translate(0) scale(1);
		opacity: 1;
		backgroubnd-color: #D20101;
	}

	9% {
		transform: translate(10px, -5px) scale(0.9);
		opacity: 1;
		background-color: #D20101;
	}

	15% {
		transform: translate(20px, -20px)scale(0.8);
		opacity: 1;
		background-color: #D20101;
	}
	30% {
		transform: translate(10px, -40px)scale(0.4);
		opacity: 0.5;
	}
	35% {
		transform: translate(12px, -44px) scale(0.4);
		opacity: 0.2;
		background-color: #d20101;
	}
	50% {
		transform: translate(0px, -55px) scale(0.2);
		opacity: 0;
	}
	100% {
		opacity: 0;
	}
`

const flame4 = keyframes`
	0%{
		transform: translate(0) scale(1);
		opacity: 1;
		background-color: #e80711;
	}
	12%{
		transform: translate(34px, -6px) scale(0.9);
		opacity: 0.7;
		background-color: #e80711;
	}

	19%{
		transform: translate(37px, -26px) scale(0.7);
		opacity: 0.5;
	}

	28%{
		transform: translate(19px, -46px) scale(0.5);
		opacity: 0.1;
		background-color: #D20101;
	}

	32%{
		transform: translate(19px, -26px) scale(0.2);
		opacity: 0;
	}
	100% {
		opacity: 0;
	}
`

const AnimatedLogoContainer = styled.div`
  padding: ${props => (props.small ? "9px 20px 9px 16px" : "20px 26px")};
  background: linear-gradient(45deg, #d20101 50%, #e5cc00 100%);
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: ${props => (props.small ? "24px" : "72px")};
  position: relative;
  color: #fff;
  font-weight: 800;
  text-decoration: none;
  margin: ${props => (props.small ? "0" : "4rem 0 4rem")};
  @media (max-width: 520px) {
    font-size: ${props => (props.small ? "24px" : "64px")};
  }
  &:after {
    content: "";
    width: ${props => (props.small ? "12px" : "25px")};
    height: ${props => (props.small ? "12px" : "25px")};
    background-color: #fff;
    position: absolute;
    top: 0;
    right: 0;
  }
`

const Flame = styled.div`
  position: absolute;
  width: ${props => (props.small ? "12px" : "25px")};
  height: ${props => (props.small ? "12px" : "25px")};
  background-color: #ecc504;
  top: 0px;
  right: 0px;
  z-index: 10;
  transform: translate(0);
  opacity: 0;
  animation: ${props => props.animation} ${props => props.duration} infinite
    ease-out;
  animation-delay: ${props => props.delay};
`

Flame.defaultProps = {
  delay: "0.0s",
}

export const AnimatedLogo = ({ small }) => (
  <AnimatedLogoContainer small={small}>
    Flame
    <div>
      <Flame animation={flame1} duration="0.8s" small={small} />
      <Flame animation={flame2} duration="1.7s" delay="0.6s" small={small} />
      <Flame animation={flame3} duration="0.8s" delay="0.9s" small={small} />
      <Flame animation={flame4} duration="2s" delay="0.2s" small={small} />
    </div>
  </AnimatedLogoContainer>
)
