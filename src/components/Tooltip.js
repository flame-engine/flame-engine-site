import React from "react"
import styled from "styled-components"

const Root = styled.div`
  position: relative;
  display: inline;
`

const TooltipBody = styled.div`
  position: absolute;
  background-color: #fff;
  box-shadow: 0 8px 42px rgba(41, 71, 124, 0.34);
  border-radius: 15px;
  transition: all 0.1s ease-out;
  opacity: 0;
  pointer-events: none;
  z-index: 10;

  &.triggered {
    opacity: 1;
    pointer-events: all;
  }

  &:after {
    content: "";
    background-color: transparent;
    display: block;
    position: absolute;
    pointer-events: none;
    border-color: transparent;
    border-style: solid;
    width: 0;
    height: 0;
    border-width: 8px;
  }
  &[data-relation="top"] {
    bottom: calc(100% - 20px);
    &.triggered {
      bottom: calc(100% + 10px);
    }
    &:after {
      top: 100%;
      border-top-color: #fff;
    }
  }
  &[data-relation="bottom"] {
    top: calc(100% - 20px);
    &.triggered {
      top: calc(100% + 10px);
    }
    &:after {
      bottom: 100%;
      border-bottom-color: #fff;
    }
  }
  &[data-relation="bottom"],
  &[data-relation="top"] {
    left: 50%;
    &[data-position="1"] {
      transform: translateX(calc(-100% + 30px)) scale(0.8);
      &.triggered {
        transform: translateX(calc(-100% + 20px)) scale(1);
      }
      &:after {
        right: 15px;
      }
    }
    &[data-position="2"] {
      transform: translateX(-50%) scale(0.8);
      &.triggered {
        transform: translateX(-50%) scale(1);
      }
      &:after {
        left: 50%;
        transform: translateX(-50%);
      }
    }
    &[data-position="3"] {
      transform: translateX(calc(0% - 40px)) scale(0.8);
      &.triggered {
        transform: translateX(calc(0% - 20px)) scale(1);
      }
      &:after {
        left: 15px;
      }
    }
  }
  &[data-relation="left"] {
    right: calc(100% - 20px);
    &.triggered {
      right: calc(100% + 20px);
    }
    &:after {
      left: 100%;
      border-left-color: #fff;
    }
  }
  &[data-relation="right"] {
    left: calc(100% - 20px);
    &.triggered {
      left: calc(100% + 20px);
    }
    &:after {
      right: 100%;
      border-right-color: #fff;
    }
  }
  &[data-relation="right"],
  &[data-relation="left"] {
    top: 50%;
    &[data-position="1"] {
      transform: translateY(calc(-100% + 40px)) scale(0.8);
      &.triggered {
        transform: translateY(calc(-100% + 20px));
      }
      &:after {
        bottom: 15px;
      }
    }
    &[data-position="2"] {
      transform: translateY(-50%) scale(0.8);
      &.triggered {
        transform: translateY(-50%);
      }
      &:after {
        top: 50%;
        transform: translateY(-50%);
      }
    }
    &[data-position="3"] {
      transform: translateY(calc(0% - 40px)) scale(0.8);
      &.triggered {
        transform: translateY(calc(0% - 20px));
      }
      &:after {
        top: 15px;
      }
    }
  }
`

export const PaperTooltip = ({
  relation,
  content,
  position,
  children,
  className,
  title,
}) => {
  const [show, setShow] = React.useState(false)
  const me = React.useRef(null)

  React.useEffect(() => {
    const clickOut = ({ target }) => {
      if (me.current && !me.current.contains(target)) {
        setShow(false)
      }
    }
    window.addEventListener("click", clickOut)

    return () => window.removeEventListener("click", clickOut)
  }, [setShow])

  return (
    <Root className={className} title={title} ref={me}>
      {children(setShow)}
      <TooltipBody
        data-relation={relation}
        data-position={position}
        className={show && " triggered"}
      >
        {content}
      </TooltipBody>
    </Root>
  )
}
