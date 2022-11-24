import { useEffect, useState, useCallback } from "react"
import React from "react"
import { createRoot } from "react-dom/client"
import ReactFlow, { MiniMap, Controls, Background, applyNodeChanges, } from 'reactflow';

const root = createRoot(document.getElementById("container"))

const Nodes = {
    mounted() { root.render(<Flow hook={this} />) }
}

function Flow({ hook }) {
    const [nodes, setNodes] = useState([]);
    const [edges, setEdges] = useState([]);
    const onNodesChange = useCallback((changes) => setNodes((nds) => applyNodeChanges(changes, nds)), []);
    useEffect(() => {
        hook.handleEvent("add_nodes", ({ nodes, edges }) => {
            setNodes(nodes)
            setEdges(edges)
        })
    }, [])
    return (
        <ReactFlow nodes={nodes} edges={edges} onNodesChange={onNodesChange} >
            <MiniMap />
            <Controls />
            <Background />
        </ReactFlow>
    );
}
export default Nodes